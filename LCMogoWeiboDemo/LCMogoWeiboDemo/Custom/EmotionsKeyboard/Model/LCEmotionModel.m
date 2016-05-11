//
//  LCEmotionModel.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/30.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCEmotionModel.h"

@implementation LCEmotionModel
MJCodingImplementation
/**
 *  比较两个LCEmotionModel模型是否一样
 *
 *  @param object LCEmotionModel
 *
 *  @return 是否一样
 */
- (BOOL)isEqual:(LCEmotionModel *)object{
    return [self.chs isEqualToString:object.chs] || [self .code isEqualToString:object.code];
}
@end
