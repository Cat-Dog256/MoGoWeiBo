//
//  LCEmotionsTool.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/11.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCEmotionModel.h"

@class LCEmotionModel;
@interface LCEmotionsTool : NSObject
/**
 *  添加最近使用的表情
 *
 *  @param emotion 表情模型
 */
+ (void)addRecentlyEmotinon:(LCEmotionModel *)emotion;
/**
 *  读取最近使用的表情
 *
 *  @return 表情模型数组
 */
+ (NSMutableArray *)recentlyEmotions;
/**
 *  读取默认表情
 *
 *  @return 表情模型数组
 */
+ (NSArray *)defaultEmotions;
/**
 *  读取emoji表情
 *
 *  @return 表情模型数组
 */
+ (NSArray *)emojiEmotions;
/**
 *  读取浪小花表情
 *
 *  @return 表情模型数组
 */
+ (NSArray *)lxhEmotions;
/**
 *  查找表情
 *
 *  @param chs 描述文字
 *
 *  @return 表情模型
 */
+ (LCEmotionModel *)emotionWithCHS:(NSString *)chs;
@end
