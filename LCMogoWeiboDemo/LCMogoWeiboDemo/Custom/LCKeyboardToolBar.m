//
//  LCKeyboardToolBar.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/28.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCKeyboardToolBar.h"

@interface LCKeyboardToolBar ()
@property (nonatomic , strong) NSMutableArray *butsArray;
@property (nonatomic , weak) LCButton *emotionButton;
@end

@implementation LCKeyboardToolBar
- (NSMutableArray *)butsArray{
    if (!_butsArray) {
        _butsArray = [NSMutableArray array];
    }
    return _butsArray;
}
- (instancetype)initWithFrame_Y:(CGFloat)toolBar_Y{
    if (self  =[super init]) {
        self.backgroundColor = kBgDarkColor;
         self.frame = CGRectMake(0, toolBar_Y, SCREEN_WIDTH, 44);
        [self addTopLineWithTopMargin:0 leftMargin:0 rightMargin:0];
        [self addDownLineWithDownMargin:0 leftMargin:0 rightMargin:0];
        
        [self setUpButtonWithNormalImage:[UIImage imageNamed:@"compose_camerabutton_background"] highlightedImage:[UIImage imageNamed:@"compose_camerabutton_background_highlighted"] andButtonType:LCKeyboardToolbarButtonTypeCamera];
        [self setUpButtonWithNormalImage:[UIImage imageNamed:@"compose_toolbar_picture"] highlightedImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] andButtonType:LCKeyboardToolbarButtonTypePicture];
        
        [self setUpButtonWithNormalImage:[UIImage imageNamed:@"compose_mentionbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"] andButtonType:LCKeyboardToolbarButtonTypeMention];
        [self setUpButtonWithNormalImage:[UIImage imageNamed:@"compose_trendbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"] andButtonType:LCKeyboardToolbarButtonTypeTrend];
        self.emotionButton = [self setUpButtonWithNormalImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"]andButtonType:LCKeyboardToolbarButtonTypeEmotion];
       
    }
    return self;
}
- (LCButton *)setUpButtonWithNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage andButtonType:(LCKeyboardToolbarButtonType)buttonType{
    LCButton *button = [[LCButton alloc]init];
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = buttonType;
    [self.butsArray addObject:button];
    
    [self addSubview:button];
    return button;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat butW = SCREEN_WIDTH/5;
    CGFloat butH = self.height;
    CGFloat butX = 0;
    CGFloat butY = 0;
    for (int i = 0 ; i < self.butsArray.count; i++) {
        LCButton *button = self.butsArray[i];
        button.x = butX + butW * i;
        button.y = butY;
        button.width = butW;
        button.height = butH;
    }
}
- (void)buttonAction:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(keyboardToolbar:didClickButton:)]) {
        [self.delegate keyboardToolbar:self didClickButton:button.tag];
    }
}
- (void)setShowKeyboardButton:(BOOL)showKeyboardButton{
    _showKeyboardButton = showKeyboardButton;
    [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
    [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    if (showKeyboardButton) {
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
