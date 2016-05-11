//
//  LCEmotionsPageView.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/9.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCEmotionsPageView.h"
#import "LCEmotionModel.h"
#import "LCEmotionPopView.h"
#import "LCEmotionButton.h"
#import "LCEmotionsTool.h"


#import "LCEmotionsConst.h"
@interface LCEmotionsPageView ()
@property (nonatomic , strong) LCEmotionPopView *popView;
@property (nonatomic , strong) LCButton *deleteButton;
@end

@implementation LCEmotionsPageView
- (LCButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [[LCButton alloc]init];
        [_deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [_deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [_deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.deleteButton];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressPageEmotionsView:)];
        [self addGestureRecognizer:longPress];
    }
    return self;
}

- (LCEmotionPopView *)popView{
    if (!_popView) {
        _popView = [LCEmotionPopView emotionPopView];
    }
    return _popView;
}
- (void)setPageEmotionsArray:(NSArray *)pageEmotionsArray{
    _pageEmotionsArray = pageEmotionsArray;
    for (int i = 0 ; i < pageEmotionsArray.count; i++) {
        LCEmotionButton *button = [[LCEmotionButton alloc]init];
       
        button.emotionModel = pageEmotionsArray[i];
        
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat inset = 10;
    CGFloat buttonW = (self.width - 2 * inset) / EmotionsPageMaxCols;
    CGFloat buttonH = (self.height - inset) / EmotionsPageMaxRows;
    for (int i = 0; i < self.pageEmotionsArray.count; i++) {
        LCButton *button = self.subviews[i + 1];
        button.x = inset + buttonW * (i%EmotionsPageMaxCols);
        button.y = inset + buttonH * (i/EmotionsPageMaxCols);
        button.width = buttonW;
        button.height = buttonH;
    }
    self.deleteButton.width = buttonW;
    self.deleteButton.height = buttonH;
    self.deleteButton.x = self.width - inset - buttonW;
    self.deleteButton.y = self.height - buttonH;
}
- (void)btnClick:(LCEmotionButton *)button{
    /**
     *  显示放大的表情
     */
//    [self.popView showFrom:button];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.26 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    [self sendNotification:button.emotionModel];
}
- (void)deleteButtonAction:(LCButton *)button{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLCEmotionKeyboardDidSelectedDeletedNotification object:nil];
}
#pragma mark --长按事件
- (void)longPressPageEmotionsView:(UILongPressGestureRecognizer *)recognizer{
    CGPoint locationPoint = [recognizer locationInView:recognizer.view];
    LCEmotionButton *button = [self emotionButtonWithLocation:locationPoint];
    switch (recognizer.state) {
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:{
            [self.popView removeFromSuperview];
            if (button) {
                [self sendNotification:button.emotionModel];
            }
            break;
        }
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:{
            [self.popView showFrom:button];
            break;
        }
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark --私有方法 判断长按的触摸点在不在表情按钮上
- (LCEmotionButton *)emotionButtonWithLocation:(CGPoint)locationPoint{
    for (int i = 0; i < self.pageEmotionsArray.count; i++) {
        LCEmotionButton *button = self.subviews[1 + i];
        if (CGRectContainsPoint(button.frame, locationPoint)) {
            return button;
        }
    }
    return nil;
}
#pragma mark --私有方法 发送选中表情的通知并存储为最近的表情
- (void)sendNotification:(LCEmotionModel *)emotion{
    [LCEmotionsTool addRecentlyEmotinon:emotion];
    NSMutableDictionary *userinfo = [NSMutableDictionary dictionary];
    userinfo[kSelectedEmotionInfo] = emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:kLCEmotionKeyboardDidSelectedEmotiomNotification object:nil userInfo:userinfo];
}
@end
