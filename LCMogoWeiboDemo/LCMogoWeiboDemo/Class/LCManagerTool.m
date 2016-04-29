//
//  LCManagerTool.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/17.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCManagerTool.h"
#import "CatchCrash.h"
@implementation LCManagerTool
+(void)makeCustomLog{
    /**
     *  发送日志语句到苹果的日志系统，以便它们显示在Console.app上
     */
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    /**
     *  发送日志语句到Xcode控制台
     */
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
//    /**
//     把日志语句发送至文件*/
//    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
//    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
//    
//    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
//    
//    [DDLog addLogger:fileLogger];
    
    // Enable Colors
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:[UIColor greenColor] forFlag:DDLogFlagVerbose];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor whiteColor] backgroundColor:[UIColor purpleColor] forFlag:DDLogFlagInfo];
    
//    LCLogError(@"错误信息"); // 红色
//    LCLogWarn(@"警告"); // 橙色
//    LCLogInfo(@"提示信息"); // 默认是黑色
//    LCLogVerbose(@"详细信息"); // 默认是黑色
    /**
     *  收集崩溃日志
     */
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    /**
     *  打印本地log文件
     */
//        [[self class] getLogPath];

}

+ (NSArray*)getLogPath
{
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString * logPath = [docPath stringByAppendingPathComponent:@"Caches"];
    logPath = [logPath stringByAppendingPathComponent:@"Logs"];
    
    
    NSFileManager * fileManger = [NSFileManager defaultManager];
    NSError * error = nil;
    NSArray * fileList = [[NSArray alloc]init];
    fileList = [fileManger contentsOfDirectoryAtPath:logPath error:&error];
    NSMutableArray * listArray = [[NSMutableArray alloc]init];
    for (NSString * oneLogPath in fileList)
    {
        if([oneLogPath hasSuffix:@".log"])
        {
            NSString * truePath = [logPath stringByAppendingPathComponent:oneLogPath];
            NSLog(@"%@",truePath);
            
            NSString *exceptionInfo = [[NSString alloc]initWithContentsOfFile:truePath encoding:NSUTF8StringEncoding error:nil];
            [listArray addObject:exceptionInfo];
        }
    }
    NSLog(@"%@",listArray);
    return listArray;
}
- (NSString *)formatLogMessage:(DDLogMessage *)logMessage{
    NSMutableDictionary *logDict = [NSMutableDictionary dictionary];
    
    //取得文件名
    NSString *locationString;
    NSArray *parts = [logMessage->_file componentsSeparatedByString:@"/"];
    NSLog(@"%@",parts);
    if ([parts count] > 0)
        locationString = [parts lastObject];
    if ([locationString length] == 0)
        locationString = @"No file";
    
    //这里的格式: {"location":"myfile.m:120(void a::sub(int)"}， 文件名，行数和函数名是用的编译器宏 __FILE__, __LINE__, __PRETTY_FUNCTION__
    logDict[@"location"] = [NSString stringWithFormat:@"%@:%lu(%@)", locationString, (unsigned long)logMessage->_line, logMessage->_function];
    
    //尝试将logDict内容转为字符串，其实这里可以直接构造字符串，但真实项目中，肯定需要很多其他的信息，不可能仅仅文件名、行数和函数名就够了的。
    NSError *error;
    NSData *outputJson = [NSJSONSerialization dataWithJSONObject:logDict options:0 error:&error];
    if (error)
        return @"{\"location\":\"error\"}";
    NSString *jsonString = [[NSString alloc] initWithData:outputJson encoding:NSUTF8StringEncoding];
    if (jsonString)
        return jsonString;
    return @"{\"location\":\"error\"}";
}
//判读邮箱
+ (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

+ (NSString *)filter_tank:(NSString *)textString{
    //表情正则表达式
    NSString *hanzi = @"[\u4e00-\u9fa5]";
    NSString *hanzibiaodian = @"[\u3000-\u301e\ufe10-\ufe19\ufe30-\ufe44\ufe50-\ufe6b\uff01-\uffee]";
    //  \\u4e00-\\u9fa5 代表unicode字符
    NSString *emopattern = @"\\[[a-zA-Z\\u4e00-\\u9fa5]+\\]";
    //@正则表达式
    NSString *atpattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5]+";
    //#...#正则表达式
    NSString *toppattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    //url正则表达式
    NSString *urlpattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    //设定总的正则表达式
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@",hanzi,hanzibiaodian,emopattern,atpattern,toppattern,urlpattern];
    //根据正则表达式设定OC规则
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    //获取匹配结果
    NSArray *results = [regular matchesInString:textString options:0 range:NSMakeRange(0, textString.length)];
    //遍历结果
    NSMutableArray *array = [NSMutableArray array];
    for (NSTextCheckingResult *result in results) {
        
        [array addObject:[textString substringWithRange:result.range]];
    }
    return  [array componentsJoinedByString:@""];
}
@end
