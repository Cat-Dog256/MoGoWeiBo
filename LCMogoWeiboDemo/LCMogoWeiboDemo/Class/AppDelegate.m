//
//  AppDelegate.m
//  MoGoWeiBo
//
//  Created by 李策 on 16/4/7.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "AppDelegate.h"
#import "LCMoGoWeiBoTabBarController.h"
#import "LCDBManager.h"
#import "LCDBConst.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
- (void)testDBTool{
    LCDBManager *myDBTool = [LCDBManager sharedManager];
    [myDBTool createTableWithName:@"account"];
        NSDictionary *dict = @{@"username":@"唐巧大V",
                           @"id":@"1",
                           @"link":@"http://blog.devtang.com"};
//        [myDBTool putObject:dict withIdentifier:@"dict" objType:@"NSDictonary" intoTable:@"account"];
//        NSDictionary *accountDict = [myDBTool getObjectByIdentifier:@"dict" fromTable:@"account"];
    
    [myDBTool putDictionary:dict withId:@"dict" intoTable:@"account"];
    NSDictionary *accountDict = [myDBTool getDictionaryById:@"dict" fromTable:@"account"];
    
    NSLog(@"%@",accountDict);
    NSArray *array = @[@{@"username":@"唐巧大V",
                         @"id":@"1",
                         @"link":@"http://blog.devtang.com"},
                       @{@"username":@"李明杰",
                         @"id":@"2",
                         @"link":@"http://blog.devtang.com"},
                       @{@"username":@"欧阳",
                         @"id":@"3",
                         @"link":@"http://blog.devtang.com"},
                       @{@"username":@"潘",
                         @"id":@"4",
                         @"link":@"http://blog.devtang.com"},
                       @{@"username":@"向军",
                         @"id":@"5",
                         @"link":@"http://blog.devtang.com"}];
    //    [myDBTool putObject:array withId:@"array" intoTable:@"account"];
    //    NSDictionary *accountArray = [myDBTool getObjectById:@"array" fromTable:@"account"];
    
    [myDBTool putArray:array withId:@"array" intoTable:@"account"];
    NSArray *accountArray = [myDBTool getArrayById:@"array" fromTable:@"account"];
    NSLog(@"%@",accountArray);
    
    [myDBTool putString:@"字符串" withId:@"String" intoTable:@"account"];
    NSString *string = [myDBTool getStringById:@"String" fromTable:@"account"];
    NSLog(@"%@",string);
    
    [myDBTool putNumber:@2016 withId:@"number" intoTable:@"account"];
    NSNumber *number = [myDBTool getNumberById:@"number" fromTable:@"account"];
    NSLog(@"%@",number);
    
    [myDBTool putBool:NO withId:@"isLogin" intoTable:@"account"];
    
    BOOL isLogin = [myDBTool getBoolById:@"isLogin" fromTable:@"account"];
    NSLog(@"%d",isLogin);
     NSString *conditionKey1 = [NSString stringWithFormat:@"%@ = ",kUniqueIdentifier];
    [myDBTool deleteDataFromTable:@"account" singleCondition:@{conditionKey1:@"number"}];
    NSString *conditionKey2 = [NSString stringWithFormat:@"%@ = ",kUniqueIdentifier];

    [myDBTool updateTable:@"account" setKeyValues:@{@"json":@"一个字符串"} singleCondition:@{conditionKey2 : @"String"}];
    
    
    NSArray *data = [myDBTool selectKeyTypes:@{@"json":@"text"} fromTable:@"account" singleCondition:@{conditionKey2:@"dict"}];
    NSLog(@"%@",data);
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    /**
     *  配置Log信息
     */
    [LCManagerTool makeCustomLog];
    
    
    self.window.backgroundColor = [UIColor whiteColor];
       self.window.rootViewController = [[LCMoGoWeiBoTabBarController alloc]init];
//    [self testDBTool];
    [self.window makeKeyAndVisible];
        // Override point for customization after application launch.
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
