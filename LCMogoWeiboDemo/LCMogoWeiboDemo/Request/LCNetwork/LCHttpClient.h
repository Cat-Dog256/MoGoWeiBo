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

@property (nonatomic , copy) LCRequsestBase *request;
@property (nonatomic , copy) Success requsetSuccess;
@property (nonatomic , copy) Failure requsetFailure;

- (void)requestWithRequester:(LCRequsestBase *)requester success:(Success)requestSuccess failure:(Failure)requestFailure;
- (void)cancel;
@end
