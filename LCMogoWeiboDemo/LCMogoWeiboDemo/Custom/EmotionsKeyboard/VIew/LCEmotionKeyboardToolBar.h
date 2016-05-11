//
//  LCEmotionKeyboardToolBar.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/29.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCEmotionKeyboardToolBar;
typedef enum {
    LCEmotionKeyboardToolBarButtonTypeRecent = 100, // 最近
    LCEmotionKeyboardToolBarButtonTypeDefault, // 默认
    LCEmotionKeyboardToolBarButtonTypeEmoji, // emoji
    LCEmotionKeyboardToolBarButtonTypeLxh, // 浪小花
} LCEmotionKeyboardToolBarButtonType;

@protocol LCEmotionKeyboardToolBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(LCEmotionKeyboardToolBar *)tabBar didSelectButton:(LCEmotionKeyboardToolBarButtonType)buttonType;
@end

@interface LCEmotionKeyboardToolBar : UIView
@property (nonatomic , weak) id<LCEmotionKeyboardToolBarDelegate>delegate;
- (void)selectedBarButton:(LCEmotionKeyboardToolBarButtonType)buttonType;
@end
