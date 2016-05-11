//
//  LCRecentlyEmotionView.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/30.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCRecentlyEmotionView.h"
#import "LCEmotionsConst.h"
@interface LCRecentlyEmotionView ()
@property (nonatomic , strong) LCLabel *label;
@end

@implementation LCRecentlyEmotionView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        LCLabel *label = [LCLabel labelWithFont:kSmallTextFont text:@"最近使用的表情"];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = kMinBlackColor;
        [self addSubview:label];
        self.label = label;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.label.frame = CGRectMake(0, self.height - PageControlH, self.width, PageControlH);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
