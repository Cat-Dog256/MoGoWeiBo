//
//  CatchCrash.m
//  WiFi
//
//  Created by MoGo on 15/12/31.
//  Copyright © 2015年 MoGo. All rights reserved.
//
#include <sys/types.h>
#include <sys/sysctl.h>
#import "CatchCrash.h"

@implementation CatchCrash
void uncaughtExceptionHandler(NSException *exception)
{
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    // 出现异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString *name = [exception name];
    NSString *platform = [NSString stringWithCString:platformString() encoding:NSUTF8StringEncoding];
    NSString *deviceVersion = platform;
    NSString *systemName = [UIDevice currentDevice].systemName;
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\r\nException name：%@\r\nException stack：%@\r\nDeviceVersion: %@\r\nSystemName: %@\r\nSystemVersion : %@",name, reason, stackArray , deviceVersion , systemName , systemVersion];
   
    LCLogError(@"%@",exceptionInfo);
    
    //保存到本地  --  当然你可以在下次启动的时候，上传这个log
//    [exceptionInfo writeToFile:[NSString stringWithFormat:@"%@/Documents/error.log",NSHomeDirectory()]  atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
char* getDeviceVersion()
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    return machine;
}
char* platformString(){
    char *platform = getDeviceVersion();
    if (strcmp( platform , "iPhone4,1") == 0)
        return "iPhone 4S (A1387/A1431)";
    if (strcmp( platform , "iPhone5,1") == 0)
        return "iPhone 5 (A1428)";
    if (strcmp( platform , "iPhone5,2") == 0)
        return "iPhone 5 (A1429/A1442)";
    if (strcmp( platform , "iPhone5,3") == 0)
        return "iPhone 5c (A1456/A1532)";
    if (strcmp( platform , "iPhone5,4") == 0)
        return "iPhone 5c (A1507/A1516/A1526/A1529)";
    if (strcmp( platform , "iPhone6,1") == 0)
        return "iPhone 5s (A1453/A1533)";
    if (strcmp( platform , "iPhone6,2") == 0)
        return "iPhone 5s (A1457/A1518/A1528/A1530)";
    if (strcmp( platform , "iPhone7,1") == 0)
        return "iPhone 6 Plus (A1522/A1524)";
    if (strcmp( platform , "iPhone7,2") == 0)
        return "iPhone 6 (A1549/A1586)";
    if (strcmp( platform , "iPhone8,1") == 0)
        return "iPhone 6S";
    if (strcmp( platform , "iPhone8,2") == 0)
        return "iPhone 6S Plus";
    if (strcmp( platform , "i386") == 0)
        return "iPhone Simulator";
    if (strcmp( platform , "x86_64") == 0)
        return "iPhone Simulator";
    return platform;
}
@end
