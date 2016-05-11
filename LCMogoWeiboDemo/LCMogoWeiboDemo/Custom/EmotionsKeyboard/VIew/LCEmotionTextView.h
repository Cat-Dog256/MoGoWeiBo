//
//  LCEmotionTextView.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/10.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCPlaceholderTextView.h"
@class LCEmotionModel;
@interface LCEmotionTextView : LCPlaceholderTextView
- (void)insertEmotion:(LCEmotionModel *)emotion;
/**
 *  要上传的字符串
 */
- (NSString *)fullText;
@end
