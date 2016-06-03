//
//  LCStatusesModel.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCStatusesModel.h"
#import "LCPicModel.h"
#import "RegexKitLite.h"
#import "LCEmotionsTool.h"

@interface LCPartText : NSObject

@property (nonatomic , strong) NSString *partString;

@property (nonatomic , assign) NSRange range;

@property (nonatomic , assign , getter=isEmotion) BOOL emotion;

@property (nonatomic , assign , getter=isUrl) BOOL url;

@property (nonatomic , assign , getter=isToptocl) BOOL toptocl;

@property (nonatomic , assign , getter=isAT) BOOL AT;
@end

@implementation LCPartText
- (NSString *)description{
    return [NSString stringWithFormat:@"%@ -- %@" , self.partString , NSStringFromRange(self.range)];
}
+ (LCPartText *)partWithString:(NSString *)partString range:(NSRange)range{
    LCPartText *part = [[self alloc]init];
    part.partString = partString;
    part.range = range;
    return part;
}

@end

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
- (void)setTextString:(NSString *)textString{
    _textString = textString;
    _attributedText = [self attributedTextWithText:textString];
}
- (NSAttributedString *)attributedTextWithText:(NSString *)textString{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];
    //表情正则表达式 \\u4e00-\\u9fa5 代表unicode字符
    NSString *emopattern = @"\\[[a-zA-Z\\u4e00-\\u9fa5]+\\]";
    //@正则表达式
    NSString *atpattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5]+";
    //#...#正则表达式
    NSString *toppattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    //url正则表达式
    NSString *urlpattern = @"[a-zA-z]+://[^\\s]*";
    //设定总的正则表达式
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@",emopattern,atpattern,toppattern,urlpattern];
    NSMutableArray *partsTextArray = [NSMutableArray array];
    [textString enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        LCPartText *part = [LCPartText partWithString:*capturedStrings range:*capturedRanges];
        if ([self validatePattern:emopattern targetText:*capturedStrings]) {
            part.emotion = YES;
        }else if([self validatePattern:atpattern targetText:*capturedStrings]){
            part.AT = YES;
        }else if ([self validatePattern:toppattern targetText:*capturedStrings]){
            part.toptocl = YES;
        }else if ([self validatePattern:urlpattern targetText:*capturedStrings]){
            part.url = YES;
        }
        [partsTextArray addObject:part];
    }];
    
    [textString enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        [partsTextArray addObject:[LCPartText partWithString:*capturedStrings range:*capturedRanges]];
    }];
    
    /**
     *  排序
     */
    [partsTextArray sortUsingComparator:^NSComparisonResult(LCPartText *obj1, LCPartText *obj2) {
        if (obj1.range.location > obj2.range.location) {
            return NSOrderedDescending;
        }else{
            return NSOrderedAscending;
        }
    }];
    
    NSMutableArray *specials = [NSMutableArray array];
    for (LCPartText *part in partsTextArray) {
        NSAttributedString *attributedPart = nil;
        if ([part isEmotion]) {
            NSString *image = [LCEmotionsTool emotionWithCHS:part.partString].png;
            if (image) {
                //拼接图片
                NSTextAttachment *achment = [[NSTextAttachment alloc]init];
                /**
                 * 文字行高
                 */
                CGFloat achmentWH = kMidTextFont.lineHeight;
                achment.image = [UIImage imageNamed:image];
                achment.bounds = CGRectMake(0, -3.5, achmentWH, achmentWH);
                attributedPart = [NSAttributedString attributedStringWithAttachment:achment];
            }else{
                attributedPart = [[NSAttributedString alloc]initWithString:part.partString];
            }
//            attributedPart = [[NSAttributedString alloc]initWithString:part.partString attributes:@{
//                                                                                         NSForegroundColorAttributeName :kRedColor                                         }];
        }else if ([part isAT]){
            attributedPart = [[NSAttributedString alloc]initWithString:part.partString attributes:@{
                                                                                                    NSForegroundColorAttributeName :kOrangeColor                                         }];
            LCSpecialTextModel *model = [[LCSpecialTextModel alloc]init];
            model.text = part.partString;
            model.range = NSMakeRange(attributedText.length, part.partString.length);
            model.specialType = specialAT;
            [specials addObject:model];
        }else if ([part isUrl]){
            attributedPart = [[NSAttributedString alloc]initWithString:part.partString attributes:@{
                                                                                                    NSForegroundColorAttributeName :kBlueColor                                         }];
            LCSpecialTextModel *model = [[LCSpecialTextModel alloc]init];
            model.text = part.partString;
            model.range = NSMakeRange(attributedText.length, part.partString.length);
            model.specialType = specialUrl;
            [specials addObject:model];
        }else if ([part isToptocl]){
            attributedPart = [[NSAttributedString alloc]initWithString:part.partString attributes:@{
                                                                                                    NSForegroundColorAttributeName :kGreenColor                                         }];
            LCSpecialTextModel *model = [[LCSpecialTextModel alloc]init];
            model.text = part.partString;
            model.range = NSMakeRange(attributedText.length, part.partString.length);
            model.specialType = specialToptocal;
            [specials addObject:model];
        }else{
            attributedPart = [[NSAttributedString alloc]initWithString:part.partString];
        }
        
        [attributedText appendAttributedString:attributedPart];
    }
    
    [attributedText addAttribute:NSFontAttributeName value:kMidTextFont range:NSMakeRange(0, attributedText.length)];
//    if (self.attributedText.length == 0) {
//        return attributedText;
//    }
    [attributedText addAttribute:@"specials" value:specials range:NSMakeRange(0, 1)];
    return attributedText;
}
//判读字符串规则
- (BOOL)validatePattern:(NSString *)pattern targetText:(NSString *)targetText{
    NSPredicate *patternTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [patternTest evaluateWithObject:targetText];
}

- (void)setRetweeted_status:(LCStatusesModel *)retweeted_status{
    _retweeted_status = retweeted_status;
     NSString *contentText = [NSString stringWithFormat:@"@%@ : %@",retweeted_status.userMessage.name ,retweeted_status.textString];
    _retweeted_attributedText = [self attributedTextWithText:contentText];
}
@end
