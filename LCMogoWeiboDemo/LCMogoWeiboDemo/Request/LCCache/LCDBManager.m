//
//  LCDBManager.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/21.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCDBManager.h"
#import "FMDB.h"
@interface LCDBManager ()
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation LCDBManager
#pragma  mark - 设置单例
static id _instance;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedManager
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
#pragma mark - init
- (instancetype)init
{
    if(self == [super init]){
        
        self.db = [FMDatabase databaseWithPath:[self dbPath:@"appCache.db"]];
        BOOL result =[self.db open];
        
#warning Question 打开不成功的处理方式
        if (!result) {//这里可以通知exception
            DBLog(@"数据库打开不成功");
        }
        
    }
    return self;
}
#pragma mark - private methods

- (NSString *)dbPath:(NSString *)dbName
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *dbPath = [cachePath stringByAppendingPathComponent:dbName];
    DBLog(@"数据库路径%@",dbPath);
    return dbPath;
}

#pragma mark - 建表
- (BOOL)createTable:(NSString *)tableName keyTypes:(NSDictionary *)keyTypes
{
    if ([self isOpen]) {
        NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@ %@ (",kCreateTableIfNotExists,tableName]];
        int count = 0;
        for (NSString *key in keyTypes) {
            count++;
            [sql appendString:key];
            [sql appendString:@" "];
            [sql appendString:[keyTypes valueForKey:key]];
            if (count != [keyTypes count]) {
                [sql appendString:@", "];
            }
        }
        [sql appendString:@")"];
        DBLog(@"%@",sql);
        BOOL re = [self.db executeUpdate:sql];
        return re;
    }
    return NO;
}
#pragma mark**插入数据**
-(BOOL)insertDataIntoTable:(NSString *)tableName keyValues:(NSDictionary *)keyValues{
    if ([self isOpen]) {
        if (![self isExistsTable:tableName]) {
            DBLog(@"不存在%@",tableName);
            return NO;
        }
        NSArray *keys = [keyValues allKeys];
        NSArray *values = [keyValues allValues];
        
        NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@ %@ (",kInsertInto, tableName]];
        NSInteger count = 0;
        for (NSString *key in keys) {
            
            [sql appendString:key];
            count ++;
            if (count < [keys count]) {
                
                [sql appendString:@", "];
            }
        }
        NSString *subValues = [NSString stringWithFormat:@") %@ (",kValues];
        
        
        [sql appendString:subValues];
        
        
        for (int i = 0; i < [values count]; i++) {
            
            [sql appendString:@"?"];
            
            if (i < [values count] - 1) {
                
                [sql appendString:@","];
            }
        }
        [sql appendString:@")"];
        
                DBLog(@"%@", sql);
        
        BOOL re = [self.db executeUpdate:sql withArgumentsInArray:values];
        if (re) {
            DBLog(@"数据库插入成功");
        }else{
            DBLog(@"数据库插入失败");
        }
        return re;
    }else{
        return NO;
    }
    
    return NO;
}
#pragma mark**删除数据**
-(BOOL)deleteDataFromTable:(NSString *)tableName singleCondition:(NSDictionary *)condition{
    BOOL result = NO;
    if ([self isExistsTable:tableName]) {
        if (condition != nil && [[condition allKeys] count] != 0) {
            NSString *sql = [NSString stringWithFormat:@"%@ %@ %@  %@ ?" , kDelete , tableName , kWhere , [condition allKeys][0]];
            DBLog(@"%@",sql);
            result = [self.db executeUpdate:sql , [condition objectForKey:[condition allKeys][0]]];
        }else{
            NSString *sql = [NSString stringWithFormat:@"%@ %@ ",kDelete ,tableName];
            DBLog(@"%@",sql);
           result = [self.db executeUpdate:sql];
        }
        return result;
    }
    return NO;
}

#pragma mark**删除所有数据**
- (BOOL)deleteAllDataFromTable:(NSString *)tableName{
  return  [self deleteDataFromTable:tableName singleCondition:nil];
}
#pragma mark**更新单条数据**
- (BOOL)updateTable:(NSString *)tableName setKeyValues:(NSDictionary *)keyValues singleCondition:(NSDictionary *)condition{
    if (![self isOpen]) {
        DBLog(@"数据库没有打开");
        return NO;
    }
    if (![self isExistsTable:tableName]) {
        DBLog(@"不存在%@",tableName);
        return NO;
    }
    BOOL result = NO;
    for (NSString *myKey in keyValues) {
        NSMutableString *sql = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%@ %@ %@ %@ = ? %@ %@ ?", kUpdate,tableName,kSet,myKey,kWhere, [condition allKeys][0]]];
        DBLog("%@",sql);
        result =[self.db executeUpdate:sql,[keyValues valueForKey:myKey],[condition valueForKey:[condition allKeys][0]]];
    }
    return result;
}
#pragma mark - 条件查询数据库中的数据
- (NSArray *)selectKeyTypes:(NSDictionary *)keyTypes
                  fromTable:(NSString *)tableName
            singleCondition:(NSDictionary *)condition
{
    return [self selectKeyTypes:keyTypes fromTable:tableName singleCondition:condition page:nil count:nil isPage:NO];
}

#pragma mark - 条件查询数据库中的数据  按照分页限制 page count可以为nil
- (NSArray *)selectKeyTypes:(NSDictionary *)keyTypes
                  fromTable:(NSString *)tableName
            singleCondition:(NSDictionary *)condition
                       page:(NSNumber *)page
                      count:(NSNumber *)count
                     isPage:(BOOL)isPage
{
    
    if (isPage) {//按照分页显示，page传的是页数，直接转换为条件的起始值
        int intPage = [page intValue];
        int myCount = [count intValue];
        page = [NSNumber numberWithInt:(intPage - 1) *myCount];
    }
    
    if ([self isOpen]) {
        FMResultSet *result;
        if (count == nil) {
            
            NSString * sql = [NSString stringWithFormat:@"%@ %@ %@ %@ ?",kSelectFrom,tableName,kWhere, [condition allKeys][0]];
            
            result =  [self.db executeQuery:sql, [condition valueForKey:[condition allKeys][0]]];
        }else{
            NSString * sql = [NSString stringWithFormat:@"%@ %@ %@ %@ ? %@ ?,?",kSelectFrom,tableName,kWhere, [condition allKeys][0],kLimit];
            
            result =  [self.db executeQuery:sql, [condition valueForKey:[condition allKeys][0]],[page integerValue],[count integerValue]];
        }
        
        return [self getArrWithFMResultSet:result keyTypes:keyTypes];
    }else
        return nil;
}
#pragma mark - 将一行数据转换为一个字典，key为字段名 返回一个字典数组
-(NSArray *)getArrWithFMResultSet:(FMResultSet *)result keyTypes:(NSDictionary *)keyTypes
{
    NSMutableArray *tempArr = [NSMutableArray array];
    while ([result next]) {
        NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
        for (int i = 0; i < keyTypes.count; i++) {
            NSString *key = [keyTypes allKeys][i];
            NSString *value = [keyTypes valueForKey:key];
            if ([value isEqualToString:kText]) {//字符串
                
                [tempDic setValue:[result stringForColumn:key] forKey:key];
            }else if([value isEqualToString:kBlob]){//二进制对象
                
                [tempDic setValue:[result dataForColumn:key] forKey:key];
                
            }else if ([value isEqualToString:kInteger]){//带符号整数类型
                
                [tempDic setValue:[NSNumber numberWithInt:[result intForColumn:key]]forKey:key];
            }
#warning Question  这两个暂时不用
            //            else if ([value isEqualToString:@"boolean"])
            //            {
            //                //                BOOL型
            //                [tempDic setValue:[NSNumber numberWithBool:[result boolForColumn:key]] forKey:key];
            //
            //            }else if ([value isEqualToString:@"date"])
            //            {
            //                //                date
            //                [tempDic setValue:[result dateForColumn:key] forKey:key];
            //            }
            
        }
        [tempArr addObject:tempDic];
    }
    return tempArr;
    
}
#pragma mark - 判断表中是否包含某行数据，查询条件为唯一标识
- (BOOL)isExistsRowWithTableName:(NSString *)tableName
                       fieldName:(NSString *)fieldName
                           value:(NSString *)value
{
    if([self isOpen]){
        NSString *sql = [NSString stringWithFormat:@"%@ %@ %@ %@ = ?",kSelectFrom,tableName,kWhere,fieldName];
        FMResultSet * set = [self.db executeQuery:sql,value];
        if ([set next]) {
            return YES;
        }
        [set close];
        return NO;
    }
    return NO;
}
#pragma mark - 判断是否存在表
- (BOOL)isExistsTable:(NSString *)tableName
{
    return [self.db tableExists:tableName];
}
#pragma mark - 判断数据库是否打开
- (BOOL)isOpen
{
    return [self.db open];
}


@end
