//
//  LCEmotionKeyboardToolBar.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/29.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCEmotionKeyboardToolBar.h"

@interface LCEmotionKeyboardToolBar ()
@property (nonatomic , strong) NSMutableArray *butsArray;
@property (nonatomic ,strong) LCButton *lastButton;
@end

@implementation LCEmotionKeyboardToolBar

- (instancetype)init{
    if (self = [super init]) {
        [self setUpButtonsWithTitle:@"最近" withType:LCEmotionKeyboardToolBarButtonTypeRecent];
        [self setUpButtonsWithTitle:@"默认"withType:LCEmotionKeyboardToolBarButtonTypeDefault];
        [self setUpButtonsWithTitle:@"Emoji" withType:LCEmotionKeyboardToolBarButtonTypeEmoji];
        [self setUpButtonsWithTitle:@"浪小花"withType:LCEmotionKeyboardToolBarButtonTypeLxh];
    }
    return self;
}
- (NSMutableArray *)butsArray{
    if (!_butsArray) {
        _butsArray = [NSMutableArray array];
    }
    return _butsArray;
}
#pragma  mark --设置默认选中
- (void)setDelegate:(id<LCEmotionKeyboardToolBarDelegate>)delegate{
    _delegate = delegate;
        [self buttonAction:(LCButton *)[self viewWithTag:LCEmotionKeyboardToolBarButtonTypeDefault]];
    
}
- (void)setUpButtonsWithTitle:(NSString *)title withType:(LCEmotionKeyboardToolBarButtonType)type{
    LCButton *button = [[LCButton alloc]init];
    [button setTitleColor:kMinBlackColor forState:UIControlStateNormal];
    [button setTitleColor:kMaxBlackColor forState:UIControlStateDisabled];
    // 设置背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if (type == LCEmotionKeyboardToolBarButtonTypeRecent) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    } else if (type == LCEmotionKeyboardToolBarButtonTypeLxh) {
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
   
    image = @"compose_emotion_table_left_normal";

    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateDisabled];
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    button.tag = type;
    [self addSubview:button];
    [self.butsArray addObject:button];
}
- (void)buttonAction:(LCButton *)buttton{
    self.lastButton.enabled = YES;
    buttton.enabled = NO;
    self.lastButton = buttton;
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:(int)buttton.tag];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat butW = SCREEN_WIDTH/self.butsArray.count;
    CGFloat butH = self.size.height;
    CGFloat butY = 0;
    CGFloat butX = 0;
    for (int i = 0 ; i < self.butsArray.count; i++) {
        LCButton *button = self.butsArray[i];
        button.frame = CGRectMake(butX + butW * i, butY, butW, butH);
        }
}
- (void)selectedBarButton:(LCEmotionKeyboardToolBarButtonType)buttonType{
    LCButton *button = (LCButton *)[self viewWithTag:buttonType];
    self.lastButton.enabled = YES;
    button.enabled = NO;
    self.lastButton = button;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
