//
//  LCTextView.m
//  sunshineTeacher
//
//  Created by MoGo on 16/6/7.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCTextView.h"
@interface LCTextView ()

kLineAttributeDeclarations

@end
@implementation LCTextView

kLineMethodImplementation

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = kBgWhiteColor;
        
        self.textColor = kMaxBlackColor;
        
        self.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))
    {
        return [super canPerformAction:action withSender:sender];
    }
    
    return false;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    kLineCalculationPosition
}


@end
