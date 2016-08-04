//
//  LCTextField.m
//  sunshineTeacher
//
//  Created by MoGo on 16/6/7.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCTextField.h"
@interface LCTextField ()

kLineAttributeDeclarations


@end

@implementation LCTextField
kLineMethodImplementation

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = kBgWhiteColor;
        
        self.textColor = kMaxBlackColor;
        self.font = [UIFont systemFontOfSize:14];
        self.isCanPaste = YES;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    kLineCalculationPosition
}


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ([UIMenuController sharedMenuController]) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    if (self.isCanPaste) {
        return [super canPerformAction:action withSender:sender];
    }
    return NO;
}



@end
