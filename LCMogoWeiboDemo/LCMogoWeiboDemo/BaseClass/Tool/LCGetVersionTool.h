//
//  LCGetVersionTool.h
//  sunshineTeacher
//
//  Created by MoGo on 16/6/7.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
// 获取APP的线上版本

#import <Foundation/Foundation.h>

@interface LCGetVersionTool : NSObject
- (void)getOnlineVersion:( void(^)(NSDictionary *dic) ) block;
@end
