//
//  LCExceptionConst.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/19.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>
//业务异常
typedef NS_ENUM(NSUInteger,LCExceptionBusiness) {
    LCExceptionBusinessSubmitFailed
};
//网络状态异常
typedef NS_ENUM(NSUInteger,LCExceptionNetState) {
    LCExceptionNetStateBroken,
    LCExceptionNetStateConnected
};
//网络返回异常
typedef NS_ENUM(NSUInteger,LCExceptionResponse) {
    LCExceptionResponseNoPage,
    LCExceptionResponseSeviceBug
};

//网络状态
//网络状态名称
extern NSString *const kNetStateKey;
//连接
extern NSString *const kNetConnected;
//断开
extern NSString *const kNetBroken;

//通知的名称
//网络状态改变的名称
extern NSString *const kNotificationNetStateChanged;
//业务异常的名称
extern NSString *const kNotificationEXBussiness;
//网络返回异常的名称
extern NSString *const kNotificationEXResponse;


@interface LCExceptionConst : NSObject

@end
