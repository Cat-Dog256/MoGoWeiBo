//
//  LCHttpClient.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/17.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCRequsestBase.h"
#import "LCResponse.h"
typedef void(^Success)(LCResponse *response);
typedef void(^Failure)(LCResponse *response);
@interface LCHttpClient : NSObject
/**
 *  请求方式/参数/URL设置的类
 */
@property (nonatomic , copy) LCRequsestBase *request;
/**
 *  成功的block
 */
@property (nonatomic , copy) Success requsetSuccess;
/**
 *  失败的block
 */
@property (nonatomic , copy) Failure requsetFailure;
/**
 *  开始网络请求
 *
 *  @param requester      请求参数设置
 *  @param requestSuccess 成功的block
 *  @param requestFailure 失败的block
 */
- (void)requestWithRequester:(LCRequsestBase *)requester success:(Success)requestSuccess failure:(Failure)requestFailure;
/**
 *  关闭所有请求
 */
- (void)cancel;
@end
