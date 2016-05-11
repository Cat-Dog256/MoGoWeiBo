//
//  LCEmotionPopView.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/9.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCEmotionPopView.h"
#import "LCEmotionButton.h"
@interface LCEmotionPopView ()

@property (weak, nonatomic) IBOutlet LCEmotionButton *bigImgBtn;
@end

@implementation LCEmotionPopView
+ (instancetype)emotionPopView{
    return [[[NSBundle mainBundle] loadNibNamed:@"LCEmotionPopView" owner:self options:nil] lastObject];
}
- (void)showFrom:(LCEmotionButton *)button{
    if (button == nil) return;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    //转换为相对window的坐标
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    self.x = CGRectGetMidX(btnFrame) - self.width/2;
    self.y = CGRectGetMidY(btnFrame) - self.height;
    self.bigImgBtn.emotionModel = button.emotionModel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
