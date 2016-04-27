//
//  LCException.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/19.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCException.h"

@implementation LCException

#pragma mark - 处理网络连接异常
- (void)processNetExceptionWithNetState:(LCExceptionNetState)netState
{
    NSString *netStateStr = nil;
    if(netState == LCExceptionNetStateConnected){
        netStateStr = kNetConnected;
    }else{
        netStateStr = kNetBroken;
    }
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[kNetStateKey] = netStateStr;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNetStateChanged object:nil userInfo:userInfo];
}

#pragma mark - 处理业务异常
- (void)processBusinessExceptionWithBusiness:(LCExceptionBusiness)business
{
    
}

#pragma mark - 处理返回异常
- (void)processResponseExceptionWithResponse:(LCExceptionResponse)Response
{
    
    
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

+ (instancetype)exception
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
