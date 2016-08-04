//
//  LCBaseModel.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
// 所有模型的父类

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface LCBaseModel : NSObject<NSCoding>

/**
*  返回接口状态码
*/
@property (nonatomic, assign) int respCode;
/**
 *  状态对应消息
 */
@property (nonatomic, copy) NSString *message;
@end
