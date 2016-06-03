//
//  LCParamsNullTool.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/30.
//  Copyright © 2016年 李策. All rights reserved.
// 请求参数不能为空的工具类

#import <Foundation/Foundation.h>

@interface LCParamsNullTool : NSObject
+ (void)writeToErrorMesLog:(NSString *)errorMes paramName:(NSString *)paramName;
@end
