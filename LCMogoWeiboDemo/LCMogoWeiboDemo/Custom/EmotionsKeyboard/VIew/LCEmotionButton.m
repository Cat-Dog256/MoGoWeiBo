//
//  LCEmotionButton.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/10.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCEmotionButton.h"
#import "LCEmotionModel.h"
#import "NSString+Emoji.h"

@implementation LCEmotionButton
- (instancetype)init{
    if (self = [super init]) {
         self.titleLabel.font = [UIFont systemFontOfSize:32];
        //高亮的时候图片不变色
        self.adjustsImageWhenHighlighted = NO;

    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        //高亮的时候图片不变色
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}
- (void)setEmotionModel:(LCEmotionModel *)emotionModel{
    _emotionModel = emotionModel;
    if (emotionModel.png) {
        [self setImage:[UIImage imageNamed:emotionModel.png] forState:UIControlStateNormal];
        
    }else if (emotionModel.code){
        [self setTitle:[emotionModel.code emoji] forState:UIControlStateNormal];
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
