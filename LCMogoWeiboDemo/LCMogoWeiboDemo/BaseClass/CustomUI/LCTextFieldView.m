
//
//  LCTextFieldView.m
//  sunshineTeacher
//
//  Created by MoGo on 16/6/7.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCTextFieldView.h"
@interface LCTextFieldView ()<UITextFieldDelegate>

@property (nonatomic,weak) UIView *rightView;//textfield右边视图

@property (nonatomic,weak) UIView *leftView;//textfield左边视图

//contentTextF的rightView距离最右边的距离
@property (nonatomic,assign) CGFloat margin;

@end

@implementation LCTextFieldView
#pragma mark 这个方法leftView必然是一个imageView
+ (instancetype)textFieldVWithKeyboardType:(UIKeyboardType)type leftImgVName:(NSString *)imgName background:(NSString *)bgName rightView:(UIView *)rightView rightViewMargin:(CGFloat)margin placeholder:(NSString *)placeholder showCornerRadius:(BOOL)b{
    
    LCTextFieldView *tfv = [[LCTextFieldView alloc] init];
    if (bgName) {
         [tfv setBackgroundImage:[UIImage imageNamed:bgName] forState:UIControlStateNormal];
    }
   
    
    tfv.contentTextF.keyboardType = type;
    tfv.contentTextF.placeholder = placeholder;
    tfv.contentTextF.backgroundColor = [UIColor clearColor];//设为透明的颜色，好映射背景
    tfv.contentTextF.font = [UIFont systemFontOfSize:16];
    //是否圆角
    if(b){
        tfv.layer.cornerRadius = 5;
        tfv.layer.masksToBounds = YES;
    }
    //是否有img
    if(imgName){
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.image = [UIImage imageNamed:imgName];
        leftView.contentMode = UIViewContentModeCenter;
        tfv.contentTextF.leftView = leftView;
        tfv.contentTextF.leftViewMode = UITextFieldViewModeAlways;
        tfv.leftView = leftView;
    }else{
        UIView *leftView = [[UIView alloc] init];
        tfv.contentTextF.leftView = leftView;
        tfv.contentTextF.leftViewMode = UITextFieldViewModeAlways;
        tfv.leftView = leftView;
    }
    
    tfv.margin = margin;
    
    [tfv addSubview:rightView];
    tfv.rightView = rightView;
    
    return tfv;
}

#pragma mark 这个构造方法的leftView和rightView是自定义的任何控件
+ (instancetype)textFieldVWithKeyboardType:(UIKeyboardType)type leftView:(UIView *)leftView rightView:(UIView *)rightView placeholder:(NSString *)placeholder{
    
    LCTextFieldView *tfv = [[LCTextFieldView alloc] init];
    tfv.contentTextF.keyboardType = type;
    tfv.contentTextF.placeholder = placeholder;
    
    tfv.contentTextF.leftView = leftView;
    tfv.contentTextF.leftViewMode = UITextFieldViewModeAlways;
    
    [tfv addSubview:rightView];
    tfv.rightView = rightView;
    
    return tfv;
}

#pragma mark 实例方法
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        LCTextField *tf = [[LCTextField alloc] init];
        tf.font = [UIFont systemFontOfSize:12];
        tf.textColor = [UIColor blackColor];
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        tf.returnKeyType = UIReturnKeyDone;
        [self addSubview:tf];
        tf.delegate = self;
        self.contentTextF = tf;
    }
    return self;
}

#pragma mark 重新布局
- (void)layoutSubviews{
    [super layoutSubviews];
    //提取公共的坐标
    CGFloat rightVW = self.rightView.width;
    CGFloat rightVH = self.rightView.height;
    if (self.rightView.height > self.height) {
        rightVH = self.height;
    }
    CGFloat rightVX = self.width-self.rightView.width-self.margin;
    CGFloat rightVY = self.height/2 - rightVH/2;
    //textfield右边视图frame
    self.rightView.frame = CGRectMake(rightVX, rightVY, rightVW, rightVH);
    //左边视图的frame
    if([self.leftView isKindOfClass:[UIImageView class]]){
        self.leftView.size = CGSizeMake(self.height, self.height);
    }else{
        self.leftView.size = CGSizeMake(10, self.height);
    }
    //提取公共尺寸
    CGFloat tfX = 0;
    CGFloat tfY = 0;
    CGFloat tfW = self.width-self.rightView.width;
    CGFloat tfH = self.height;
    //输入源TF frame
    self.contentTextF.frame = CGRectMake(tfX, tfY, tfW, tfH);
    
}

#pragma mark 设置高亮的方法
- (void)setHighlighted:(BOOL)highlighted{
    
}

#pragma mark - getter
- (NSString *)curText{
    return self.contentTextF.text;
}

#pragma mark - setter
- (void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    self.contentTextF.font = textFont;
}

#pragma mark - setter
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.contentTextF.textColor = textColor;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.contentTextF resignFirstResponder];
    return NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
