//
//  LCKeyboardToolBar.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/28.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCView.h"

typedef  enum  NSInteger{
    LCKeyboardToolbarButtonTypeCamera, // 拍照
    LCKeyboardToolbarButtonTypePicture, // 相册
    LCKeyboardToolbarButtonTypeMention, // @
    LCKeyboardToolbarButtonTypeTrend, // #
    LCKeyboardToolbarButtonTypeEmotion // 表情
} LCKeyboardToolbarButtonType;
@class LCKeyboardToolBar;
@protocol  LCKeyboardToolBarDelegate<NSObject>

- (void)keyboardToolbar:(LCKeyboardToolBar *)toolbar didClickButton:(LCKeyboardToolbarButtonType)buttonType;

@end

@interface LCKeyboardToolBar : LCView
@property (nonatomic , strong) id<LCKeyboardToolBarDelegate>delegate;
@property (nonatomic , assign) BOOL showKeyboardButton;
/**
 *  构造方法
 *
 *  @param toolBar_Y 纵坐标
 *
 *  @return LCKeyboardToolBar
 */
- (instancetype)initWithFrame_Y:(CGFloat)toolBar_Y;
@end
