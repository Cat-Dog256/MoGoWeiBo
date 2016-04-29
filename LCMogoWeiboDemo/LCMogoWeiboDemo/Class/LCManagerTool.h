//
//  LCManagerTool.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/17.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCManagerTool : NSObject
/**
 *  自定义Log信息
 */
+ (void)makeCustomLog;
/**
 *  过滤到微博正文中的非法字符
 *
 *  @param textString 微博正文
 *
 *  @return 顾虑后的字符串
 */
+ (NSString *)filter_tank:(NSString *)textString;
@end
