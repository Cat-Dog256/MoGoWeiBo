//
//  LCButton.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/28.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCButton.h"

@interface LCButton ()
kLineAttributeDeclarations
@property (nonatomic , copy) buttonAction  btnAction;
@end

@implementation LCButton
kLineMethodImplementation

- (instancetype)initWithFrame:(CGRect)frame titleLabelFont:(CGFloat)font text:(NSString *)text buttonAction:(buttonAction)btnAction{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kBgWhiteColor;

        [self setTitleColor:kMaxBlackColor forState:UIControlStateNormal];
        [self setTitleColor:kMinBlackColor forState:UIControlStateHighlighted];

        self.titleLabel.font = [UIFont systemFontOfSize:font];
        [self setTitle:text forState:UIControlStateNormal];
        [self addTarget:self action:@selector(pressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.btnAction = btnAction;
    }
     return self;
}
- (void)addAction:(buttonAction)btnAction{
    [self addTarget:self action:@selector(pressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.btnAction = btnAction;
}
- (void)pressButtonAction:(LCButton *)button{
    self.btnAction(button);
}
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = kBgWhiteColor;
        [self setTitleColor:kMaxBlackColor forState:UIControlStateNormal];
        self.titleLabel.font = kMidTextFont;

    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = kBgWhiteColor;
        [self setTitleColor:kMaxBlackColor forState:UIControlStateNormal];
        self.titleLabel.font = kMidTextFont;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kBgWhiteColor;
        [self setTitleColor:kMaxBlackColor forState:UIControlStateNormal];
        self.titleLabel.font = kMidTextFont;

    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    kLineCalculationPosition
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
