//
//  LCRechabilityManager.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/19.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@class LCReachabilityManager;
@protocol  LCReachabilityManagerDeltgate<NSObject>

- (void)reachablitiyManager:(LCReachabilityManager *)manager status:(AFNetworkReachabilityStatus)status;
@end

@interface LCReachabilityManager : NSObject
@property (nonatomic , weak) id<LCReachabilityManagerDeltgate>delegate;
@property (readonly, nonatomic , assign) AFNetworkReachabilityStatus networkReachabilityStatus;
@property (readonly , nonatomic , assign , getter=isReachable) BOOL reachable;
@property (readonly , nonatomic , assign , getter=isReachableViaWWAN) BOOL reachableViaWWAN;
@property (readonly , nonatomic , assign , getter=isReachableViaWiFi) BOOL reachableViaWiFi;
+ (instancetype)sharedReachabilityManager;
- (void)sharedNetworkReachability;
- (void)httpManagerReachabitiyWithBaseURL:(NSString *)baseURL;
- (void)starMonitoring:(AFNetworkReachabilityManager *)reachablityManager;
- (void)stopMonitoring;
- (AFNetworkReachabilityStatus)currentStatus;
@end
