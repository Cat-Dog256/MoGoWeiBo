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
/**
 *  网络检查的代理
 *
 *  @param manager 网络状态管理者
 *  @param status  网络状态
 */
- (void)reachablitiyManager:(LCReachabilityManager *)manager status:(AFNetworkReachabilityStatus)status;
@end

@interface LCReachabilityManager : NSObject
/**
 *  代理
 */
@property (nonatomic , weak) id<LCReachabilityManagerDeltgate>delegate;
/**
 *  网路状态
 */
@property (readonly, nonatomic , assign) AFNetworkReachabilityStatus networkReachabilityStatus;
/**
 *  有网络
 */
@property (readonly , nonatomic , assign , getter=isReachable) BOOL reachable;
/**
 *  数据网络
 */
@property (readonly , nonatomic , assign , getter=isReachableViaWWAN) BOOL reachableViaWWAN;
/**
 *  WiFi
 */
@property (readonly , nonatomic , assign , getter=isReachableViaWiFi) BOOL reachableViaWiFi;
/**
 *  单例
 *
 *  @return 创建网络请求管理者
 */
+ (instancetype)sharedReachabilityManager;
/**
 *  开始网络监测
 */
- (void)sharedNetworkReachability;
/**
 *  开始网络监测
 *
 *  @param baseURL 服务器url
 */
- (void)httpManagerReachabitiyWithBaseURL:(NSString *)baseURL;
/**
 *  开始网络监测
 *
 *  @param reachablityManager AFNetworkReachabilityManager
 */
- (void)starMonitoring:(AFNetworkReachabilityManager *)reachablityManager;
/**
 *  停止
 */
- (void)stopMonitoring;
/**
 *  获取
 *
 *  @return 网络状态
 */
- (AFNetworkReachabilityStatus)currentStatus;
@end
