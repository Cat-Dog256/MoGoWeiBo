//
//  LCRechabilityManager.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/19.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCReachabilityManager.h"

@interface LCReachabilityManager ()
{
    AFHTTPSessionManager *manager;
}
@end

@implementation LCReachabilityManager
- (void)sharedNetworkReachability{
    __weak __typeof(self)weakself = self;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        ReqLog(@"%@", AFStringFromNetworkReachabilityStatus(status));
        if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(reachablitiyManager:status:)]) {
            [weakself.delegate reachablitiyManager:weakself status:status];
        }
    }];
    [self starMonitoring:[AFNetworkReachabilityManager sharedManager]];
}

- (void)httpManagerReachabitiyWithBaseURL:(NSString *)baseURL{
    NSURL *url = [NSURL URLWithString:baseURL];
    /**
     检查网络状态
     */
    if (!manager) {
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:url];
    }
    NSOperationQueue *operationQueue = manager.operationQueue;
    __weak __typeof(self)weakSelf = self;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
              case AFNetworkReachabilityStatusReachableViaWiFi:  [operationQueue setSuspended:NO];
                break;
               case AFNetworkReachabilityStatusNotReachable:
            default:[operationQueue setSuspended:YES];
                break;
            }
        
        if (weakSelf.delegate || [weakSelf.delegate respondsToSelector:@selector(reachablitiyManager:status:)]) {
            [weakSelf.delegate reachablitiyManager:weakSelf status:status];
        }

    }];
    [self starMonitoring:manager.reachabilityManager];
}

- (void)starMonitoring:(AFNetworkReachabilityManager *)reachablityManager{
    [reachablityManager startMonitoring];
}

- (void)stopMonitoring{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}
-(AFNetworkReachabilityStatus)currentStatus{
    return [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
}
- (BOOL)isReachable{
    return [[AFNetworkReachabilityManager sharedManager]isReachable];
}
- (BOOL)isReachableViaWiFi{
    return [[AFNetworkReachabilityManager sharedManager]isReachableViaWiFi];
}
- (BOOL)isReachableViaWWAN{
    return [[AFNetworkReachabilityManager sharedManager]isReachableViaWWAN];
}
- (AFNetworkReachabilityStatus)networkReachabilityStatus{
    return [[AFNetworkReachabilityManager manager]networkReachabilityStatus];
}
#pragma  mark - 设置单例
static id _instace;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

+ (instancetype)sharedReachabilityManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instace;
}
@end
