//
//  LCAlertVIew.h
//  sunshineTeacher
//
//  Created by MoGo on 16/6/10.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCAlertView;
@protocol LCAlertViewDelegate <NSObject>

- (void)alertView:(LCAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

//点击了按钮的通知
extern NSString *const kNotificationAlertViewClick;
//按钮index 键
extern NSString *const kIndex;
@interface LCAlertView : UIView
/**
 *  内容视图
 */
@property (nonatomic, strong) UIView *contentView;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  提示语句
 */
@property (nonatomic, copy) NSString *message;
/**
 *  图标
 */
@property (nonatomic, strong) UIImage *iconImage;
/**
 *  代理
 */
@property (nonatomic, weak) id<LCAlertViewDelegate> delegate;
/**
 *  初始化设置alertView
 *
 *  @param title        标题
 *  @param icon         图标
 *  @param message      提示信息
 *  @param delegate     代理
 *  @param buttonTitles 按钮标题
 */
- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon message:(NSString *)message delegate:(id<LCAlertViewDelegate>)delegate buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 *  显示当前alertView在Window上
 */
- (void)show;

/**
 *  隐藏alertView并且移除
 */
- (void)hide;

/**
 *  设置标题颜色与字体，默认为黑色,14号字体
 */
- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size;

/**
 *  设置提示信息颜色与字体，默认为黑色,12号字体
 */
- (void)setMessageColor:(UIColor *)color fontSize:(CGFloat)size;

/**
 *  设置按钮文字颜色与字体，默认为黑色,16号字体
 */
- (void)setButtonTitleColor:(UIColor *)color fontSize:(CGFloat)size atIndex:(NSInteger)index;

@end



