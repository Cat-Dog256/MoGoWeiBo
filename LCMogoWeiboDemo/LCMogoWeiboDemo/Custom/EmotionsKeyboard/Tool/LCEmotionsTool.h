//
//  LCEmotionsTool.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/11.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LCEmotionModel;
@interface LCEmotionsTool : NSObject
+ (void)addRecentlyEmotinon:(LCEmotionModel *)emotion;
+ (NSMutableArray *)recentlyEmotions;
@end
