//
//  LCException.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/19.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCExceptionConst.h"
@interface LCException : NSObject
@property (nonatomic, assign, getter=isOnline) BOOL online;
/**
 *  业务异常
 */
@property (nonatomic, assign)LCExceptionBusiness LcEXBusiness;
/**
 *  网络异常
 */
@property (nonatomic, assign)LCExceptionNetState LcEXNetState;
/**
 *  网络返回异常
 */
@property (nonatomic, assign)LCExceptionResponse LcResponse;

+ (instancetype)exception;
/**
 *  处理网络连接异常
 *
 *  @param netState 网络状态
 */
- (void)processNetExceptionWithNetState:(LCExceptionNetState)netState;
/**
 *  处理业务异常
 *
 *  @param business 业务异常内容
 */
- (void)processBusinessExceptionWithBusiness:(LCExceptionBusiness)business;
/**
 *  处理返回异常
 *
 *  @param Response 返回异常内容
 */
- (void)processResponseExceptionWithResponse:(LCExceptionResponse)Response;


@end
