//
//  LCTextFieldView.h
//  sunshineTeacher
//
//  Created by MoGo on 16/6/7.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCButton.h"

@interface LCTextFieldView : LCButton
/**
 *  当前输入的内容
 */
@property (nonatomic,strong) NSString *curText;

/**
 *  输入源TF
 */
@property (nonatomic,weak) LCTextField *contentTextF;

/**
 *  字体
 */
@property (nonatomic,strong) UIFont *textFont;

/**
 *  字体颜色
 */
@property (nonatomic,strong) UIColor *textColor;


/**
 *  leftV为imageV的构造方法
 *
 *  @param type        键盘类型
 *  @param imgName     leftV(ImageV)的图片名
 *  @param bgName      背景图片名
 *  @param rightView   右视图  需提供size
 *  @param margin      rightView距离最右边的距离
 *  @param placeholder placehorder
 *  @param b           是否显示圆角(根据提供的背景图决定)
 *
 *  @return instancetype
 */
+ (instancetype)textFieldVWithKeyboardType:(UIKeyboardType)type
                              leftImgVName:(NSString *)imgName
                                background:(NSString *)bgName
                                 rightView:(UIView *)rightView
                           rightViewMargin:(CGFloat)margin
                               placeholder:(NSString *)placeholder
                          showCornerRadius:(BOOL)b;


/**
 *  leftV自定义的构造方法
 *
 *  @param type        键盘类型
 *  @param leftView    leftV 需提供size
 *  @param rightView   右视图  需提供size
 *  @param placeholder placehorder
 *
 *  @return instancetype
 */
+ (instancetype)textFieldVWithKeyboardType:(UIKeyboardType)type
                                  leftView:(UIView *)leftView
                                 rightView:(UIView *)rightView
                               placeholder:(NSString *)placeholder;


@end
