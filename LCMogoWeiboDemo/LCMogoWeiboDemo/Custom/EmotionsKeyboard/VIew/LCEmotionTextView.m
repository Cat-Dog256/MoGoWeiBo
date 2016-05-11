//
//  LCEmotionTextView.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/10.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCEmotionTextView.h"
#import "LCEmotionModel.h"
#import "NSString+Emoji.h"
#import "LCAttachment.h"
@implementation LCEmotionTextView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentNatural;
    }
    return self;
}
- (void)insertEmotion:(LCEmotionModel *)emotion{
    if (emotion.code) {
        /**
         *  光标位置插入文字
         */
        [self insertText:emotion.code.emoji];
    }else if (emotion.png){
        UIImage *image = [UIImage imageNamed:emotion.png];
        
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];
        /**
         *  拼接之前的文字
         */
        [attributedText appendAttributedString:self.attributedText];
        //拼接图片
        LCAttachment *achment = [[LCAttachment alloc]init];
        //把表情模型绑定给achment
        achment.emotion = emotion;
        /**
         * 文字行高
         */
        CGFloat achmentWH = self.font.lineHeight;
        achment.image = image;
        achment.bounds = CGRectMake(0, -4, achmentWH, achmentWH);
        NSAttributedString *imgString = [NSAttributedString attributedStringWithAttachment:achment];
        
        NSUInteger loc = self.selectedRange.location;
        
        //插入
//        [attributedText insertAttributedString:imgString atIndex:loc];
        //替换选中
        [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:imgString];
        [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        self.attributedText = attributedText;
        self.selectedRange = NSMakeRange(loc + 1, 0);
    }
}

- (NSString *)fullText{
    NSMutableString *fullStr = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
    NSAttributedString *attributedString =  [self.attributedText attributedSubstringFromRange:range];
        if (attrs[@"NSAttachment"]) {
            //取出绑定的表情模型
            LCAttachment *achment = attrs[@"NSAttachment"];
            LCEmotionModel *emotion = achment.emotion;
            [fullStr appendString:emotion.chs];
        }else{
            [fullStr appendString:attributedString.string];
        }
//        LCLogInfo(@"%@ -- %@",attrs , attributedString);
        
    }];
    return fullStr;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
