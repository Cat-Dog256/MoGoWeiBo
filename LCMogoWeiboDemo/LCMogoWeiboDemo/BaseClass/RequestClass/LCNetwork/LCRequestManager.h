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
/**
 *  请求成功的回调
 *
 *  @param response 请求返回对的内容
 */
- (void)requestSuccess:(LCResponse *)response;
/**
 *  请求失败的回调
 *
 *  @param response 请求返回内容
 */
- (void)requestFailure:(LCResponse *)response;

@end
@interface LCRequestManager : NSObject<LCReachabilityManagerDeltgate>
/**
 *  请求管理类的代理
 */
@property (nonatomic , weak) id<LCRequestManagerDelegate>delegate;
/**
 *  封住的AFN请求
 */
@property (nonatomic , strong) LCHttpClient *httpClient;
/**
 *  开始请求
 *
 *  @param request 请求参数类
 *  @param view    loading
 */
- (void)startRequest:(LCRequsestBase *)request withView:(UIView *)view;
/**
 *  关闭所有请求
 */
- (void)cancelAllOperations;
@end
