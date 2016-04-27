//
//  LCRequestManager.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/19.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCHttpClient.h"
#import "LCReachabilityManager.h"
@class LCRequestManager;
@protocol LCRequestManagerDelegate<NSObject>

- (void)requestSuccess:(LCResponse *)response;

- (void)requestFailure:(LCResponse *)response;

@end
@interface LCRequestManager : NSObject<LCReachabilityManagerDeltgate>
@property (nonatomic , weak) id<LCRequestManagerDelegate>delegate;
@property (nonatomic , strong) LCHttpClient *httpClient;
+ (instancetype)sharedManager;
- (void)startRequest:(LCRequsestBase *)request withView:(UIView *)view;
- (void)cancelAllOperations;
@end
