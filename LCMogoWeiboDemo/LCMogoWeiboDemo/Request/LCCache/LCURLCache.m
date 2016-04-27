//
//  LCURLCache.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/21.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCURLCache.h"
#import "LCDBManager.h"
#define kTimeDeviation 3.0
#define kDafultExpiredTime 60

@interface LCURLCache ()
@property (nonatomic, strong) LCDBManager *dbManager;

@end

@implementation LCURLCache
#pragma mark - public methods

#pragma mark - 查询是否存在（包括缓存时间判断，缓存是否存在）
- (BOOL)isExistCache:(NSString *)identifier expiredTime:(LCCacheExpiredTime)expiredTime
{
    if (![self isExistCache:identifier]) {
        DBLog(@"不存在");
        return NO;
    }
    if (![self isCacheEffectiveWithIdentifier:identifier expiredTime:expiredTime]) {
        DBLog(@"过期");
        return NO;
    }
    return YES;
}

#pragma mark - 是否有缓存

- (BOOL)isExistCache:(NSString *)identifier
{
    if (![self.dbManager isOpen]) {//无库
        return NO;
    }
    if (![self.dbManager isExistsTable:kLCCacheTable]) {//无表
        return NO;
    }
    //查identifier的数据数据库中有没有
    if (![self.dbManager isExistsRowWithTableName:kLCCacheTable fieldName:kUniqueIdentifier value:identifier]){//没有
        return NO;
    }
    return YES;
}

#pragma mark - 查询缓存是否有效 也就是是否过期，返回yes 没过期
- (BOOL)isCacheEffectiveWithIdentifier:(NSString *)identifier expiredTime:(LCCacheExpiredTime)expiredTime
{
    if (![self isExistCache:identifier]) {
        return NO;
    }
    if(expiredTime != LCCacheExpiredTimeForever){
        //取出缓存时间
        NSString *conditionKey = [NSString stringWithFormat:@"%@ = ",kUniqueIdentifier];
        NSArray * timeArr = [self.dbManager selectKeyTypes:@{kCreateTime: kText} fromTable:kLCCacheTable singleCondition:@{conditionKey:identifier}];
        //缓存时间的字符串
        NSString *createTime = timeArr[0][kCreateTime];
        //讲字符串转化为date
        NSDate *createDate = [self dateFromString:createTime];
        
        if(expiredTime < self.defultExpiredTime){
            expiredTime = self.defultExpiredTime;
        }
        return [self compareNowDateAndCacheDataCreateTime:createDate withExpaireTime:expiredTime];
    }
    return YES;
}
#pragma mark - 添加缓存
- (BOOL)addCacheWithContent:(id)contentDic
                cachePolicy:(LCRequestCachePolicy)cachePolicy
                   userInfo:(NSDictionary *)userInfo
                 identifier:(NSString *)identifier
{
    if(cachePolicy == LCRequestCacheDB){//缓存策略为数据库缓存
        if (![self.dbManager isOpen]) {//无库
            return NO;
        }
        if (![self.dbManager isExistsTable:kLCCacheTable]) {//无表
            //建表
            NSMutableDictionary *keyTypes = [NSMutableDictionary dictionary];
            
            NSString *primaryKeyType = [NSString stringWithFormat:@"%@ %@",kInteger,kPrimaryKeyAutoIncrement];
            NSString *uniqueIdenType = [NSString stringWithFormat:@"%@ %@ %@ %@",kText,kNot,kNull,kUnique];
            
            [keyTypes setObject:primaryKeyType forKey:kId];
            [keyTypes setObject:kInteger forKey:kUserId];
            [keyTypes setObject:uniqueIdenType forKey:kUniqueIdentifier];
            [keyTypes setObject:kBlob forKey:kContent];
            [keyTypes setObject:kText forKey:kCreateTime];
            [keyTypes setObject:kText forKey:kCacheArchivedType];
            BOOL result = [self.dbManager createTable:kLCCacheTable keyTypes:keyTypes];
            //判断建表是否成功
            if (!result) {//建表bu成功
                DBLog(@"建表不成功");
                return NO;
            }
        }
        
        //能到这说明有库也有表了,插入数据
        NSMutableDictionary *keyValues = [NSMutableDictionary dictionary];
        
        //1.用户kUserId
        if([userInfo objectForKey:kUserId]){
            [keyValues setObject:[userInfo objectForKey:kUserId] forKey:kUserId];
        }
        //2.数据唯一标识kUniqueIdentifier
        [keyValues setObject:identifier forKey:kUniqueIdentifier];
        
        //3.数据kContent
        if (contentDic) {//如果存在数据
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:contentDic];
            [keyValues setObject:data forKey:kContent];
        }
        //4.创建时间kCreateTime
        NSString *createTime = [[self dateFormatter] stringFromDate:[NSDate date]];
        
        [keyValues setObject:createTime forKey:kCreateTime];
        //5.归档类型kArchivedType
        [keyValues setObject:self.archivedType forKey:kCacheArchivedType];
        return [self.dbManager insertDataIntoTable:kLCCacheTable keyValues:keyValues];
        
    }else if (cachePolicy == LCRequestCacheFile){//缓存的策略为磁盘缓存
#warning TODO 存磁盘的代码
        return YES;
    }
    return YES;
}

#pragma mark - 取缓存
- (id)getBackData:(NSString *)identifier
{
       if([self.dbManager isExistsRowWithTableName:kLCCacheTable fieldName:kUniqueIdentifier value:identifier]){
        NSString *conditionKey = [NSString stringWithFormat:@"%@ = ",kUniqueIdentifier];
        NSArray *result = [self.dbManager selectKeyTypes:@{kContent : kBlob}
                                           fromTable:kLCCacheTable
                                     singleCondition:@{conditionKey :identifier}];
         
           

        NSDictionary *tempDic = [result firstObject];
        NSData *firstData = [NSData dataWithData:[tempDic valueForKey:kContent]];
           
           
        NSArray *resultDataType = [self.dbManager selectKeyTypes:@{kCacheArchivedType : kText}
                                                          fromTable:kLCCacheTable
                                                    singleCondition:@{conditionKey :identifier}];
           
    
        NSString *unarchiverType = [[resultDataType firstObject] valueForKey:kCacheArchivedType];
        if ([unarchiverType isEqualToString:kCacheArchiverArray]) {
            NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:firstData];
            return array;
        }else if ([unarchiverType isEqualToString:kCahceArchiverDictionary]){
            NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
            [dataDic setValuesForKeysWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:firstData]];
            return dataDic;
        }
    }
    return nil;
}

#pragma mark - 更新缓存
- (BOOL)updateDataWithIdentifier:(NSString *)identifier content:(id)contentDic
{
    if([self.dbManager isExistsRowWithTableName:kLCCacheTable fieldName:kUniqueIdentifier value:identifier]){
        NSMutableDictionary *keyValues = [NSMutableDictionary dictionary];
        
        NSString *conditionKey = [NSString stringWithFormat:@"%@ = ",kUniqueIdentifier];
        NSString * updateTime = [[self dateFormatter] stringFromDate:[NSDate date]];
        
        [keyValues setObject:updateTime forKey:kCreateTime];
        
        if(contentDic){
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:contentDic];
            [keyValues setObject:data forKey:kContent];
        }
        return [self.dbManager updateTable:kLCCacheTable setKeyValues:keyValues singleCondition:@{conditionKey : identifier}];
    }
    return NO;
}
#pragma mark - 清除缓存
- (BOOL)cleanCache:(NSString *)identifier
{
    if([self.dbManager isExistsRowWithTableName:kLCCacheTable fieldName:kUniqueIdentifier value:identifier]){
        NSDictionary *conditionDic =@{kUniqueIdentifier : identifier};
        return [self.dbManager deleteDataFromTable:kLCCacheTable singleCondition:conditionDic];
    }
    return NO;
}
#pragma mark - private methods

#pragma mark - 比对当前时间与缓存创建时间，算出间隔与过期时间相比较判断是否没过期，返回yes为没过期
- (BOOL)compareNowDateAndCacheDataCreateTime:(NSDate *)createTime withExpaireTime:(NSTimeInterval)expiredTime
{
    //取出当前时间
    NSDate *nowDate = [NSDate date];
    //算出当前时间与创建时间的间隔
    NSTimeInterval interval = [nowDate timeIntervalSinceDate:createTime];
    if (interval >= (expiredTime + kTimeDeviation)) {//kTimeDeviation为时间偏差，经过测试interval要比实际的多0.几秒,间隔时间大于等于缓存时间，缓存过期
        return NO;
    }
    //缓存没有过期
    return YES;
}
#pragma mark - 将一定格式的时间字符串转化为NSDate
- (NSDate *)dateFromString:(NSString *)dateStr
{
    return [[self dateFormatter] dateFromString:dateStr];
}
#pragma mark - 初始化时间格式并设定
- (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return dateFormatter;
}
#pragma mark - 初始化方法
- (instancetype)init
{
    if(self == [super init]){
        [self initData];
    }
    return self;
}
- (void)initData
{
    //设置默认过期时间 暂定为1500秒
    self.defultExpiredTime = kDafultExpiredTime;
    self.dbManager = [LCDBManager sharedManager];
}
#pragma mark - 设置单例
static id _instance;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedCache
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

@end
