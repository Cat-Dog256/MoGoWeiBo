//
//  LCView.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/24.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCView.h"
@interface LCView ()
kLineAttributeDeclarations

@end

@implementation LCView
kLineMethodImplementation

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = kBgWhiteColor;
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = kBgWhiteColor;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kBgWhiteColor;
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
