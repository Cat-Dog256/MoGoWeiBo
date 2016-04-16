//
//  LCTabBar.m
//  MoGoWeiBo
//
//  Created by 李策 on 16/4/7.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCTabBar.h"

@interface LCTabBar ()

@property (nonatomic , weak) UIButton *plusButton;
@end

@implementation LCTabBar
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusButton addTarget:self action:@selector(clickPlusButton:) forControlEvents:UIControlEventTouchUpInside];
        
//        plusButton.backgroundColor = [UIColor redColor];
        self.plusButton = plusButton;
//        NSLog(@"%@",NSStringFromCGRect(plusButton.frame));
        [self addSubview:plusButton];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
//    NSLog(@"layoutSubviews");
    NSUInteger tabBarButtonIndex = 0;
    //设置+按钮的尺寸
    self.plusButton.frame = CGRectMake(self.bounds.size.width / 5 * 2,0, self.bounds.size.width / 5, self.bounds.size.height);
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
        
            view.frame = CGRectMake(self.bounds.size.width / 5 * tabBarButtonIndex, 0, self.bounds.size.width / 5, self.bounds.size.height);
            
            tabBarButtonIndex++;
            
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex++;
            }
        }
    }
}
- (void)clickPlusButton:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.tabBar_delegate tabBarDidClickPlusButton:self];
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
