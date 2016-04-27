//
//  LCStatusesModel.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCStatusesModel.h"
#import "LCPicModel.h"
@implementation LCStatusesModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"userMessage" : @"user" , @"textString" : @"text"};
}
- (NSArray *)pic_urls{
    /**
     把第一张图换成高清的图片
     */
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:_pic_urls];
    if (self.original_pic) {
        LCPicModel *model = [[LCPicModel alloc]init];
        model.thumbnail_pic = self.original_pic;
        [array replaceObjectAtIndex:0 withObject:model];
    }
    
    return array;

}

+ (NSDictionary *)objectClassInArray{
    return @{@"pic_urls":@"LCPicModel"};
}

- (NSString *)created_at{
    //    Sat Oct 17 19:11:36 +0800 2015
    
    /*
     E 星期
     M 月
     d 日
     H 24小时制时间
     m 分
     s 秒
     Z 时区
     y 年
     */
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //真机环境 ， 转换欧美时间 需要设置locale
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    NSDate *cretaeDate = [formatter dateFromString:_created_at];
    
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *nowDate = [NSDate date];
    //创建日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获取那些值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //    //z计算两个时间的相差
    NSDateComponents *component = [calendar components:unit fromDate:cretaeDate toDate:nowDate options:0];
    //    //获得Date的 年 月 日 时 分 秒   分开
    //    NSDateComponents *createCom = [calendar components:unit fromDate:cretaeDate];
    //    NSDateComponents *nowCom = [calendar components:unit fromDate:nowDate];
    if ([self isThisYear:cretaeDate]) {
        if ([self isYesterday:cretaeDate]) {
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:cretaeDate];
        }else if([self isToday:cretaeDate]){
            if(component.hour >= 1){
                return [NSString stringWithFormat:@"%ld小时前",(long)component.hour];
            }else if (component.minute >= 1){
                return [NSString stringWithFormat:@"%ld分钟前",(long)component.minute];
            }else{
                return @"刚刚";
            }
        }else{//今年其他日期
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:cretaeDate];
        }
    }else{//非今年
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [formatter stringFromDate:cretaeDate];
    }
    return [formatter stringFromDate:cretaeDate];
}
#pragma mark**判断是不是今年**
- (BOOL)isThisYear:(NSDate *)date{
    NSDate *nowDate = [NSDate date];
    
    //创建日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获取那些值
    NSCalendarUnit unit = NSCalendarUnitYear;
    //获得Date的 年 月 日 时 分 秒   分开
    NSDateComponents *createCom = [calendar components:unit fromDate:date];
    NSDateComponents *nowCom = [calendar components:unit fromDate:nowDate];
    return createCom.year == nowCom.year;
}
#pragma mark**判断是不是昨天**

- (BOOL)isYesterday:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSString *nowStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *createDate = [dateFormatter dateFromString:dateStr];
    NSDate *nowDate = [dateFormatter dateFromString:nowStr];
    
    
    //创建日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    //z计算两个时间的相差
    NSDateComponents *component = [calendar components:unit fromDate:createDate toDate:nowDate options:0];
    return component.year == 0 && component.month == 0 && component.day == 1;
}
#pragma mark**判断是不是今天**

- (BOOL)isToday:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSString *nowStr = [dateFormatter stringFromDate:[NSDate date]];
    return [dateStr isEqualToString:nowStr];
}

- (void)setSource:(NSString *)source{
    /**
     *  截取的字符长度<a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
     */
    if (source.length) {
        NSRange range;
        range.location = [source rangeOfString:@">"].location + 1;
        
        range.length = [source rangeOfString:@"</"].location - range.location;
        
        
        
        _source = [NSString stringWithFormat:@"来自 %@",[source substringWithRange:range]];

    }
    
}

@end
