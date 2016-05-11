//
//  LCEmotionPopView.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/9.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCEmotionButton;
@interface LCEmotionPopView : UIView

- (void)showFrom:(LCEmotionButton *)button;
+ (instancetype)emotionPopView;
@end
