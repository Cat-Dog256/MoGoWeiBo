//
//  LCStatusTextView.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/16.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCStatusTextView.h"
#import "LCSpecialTextModel.h"
#import "LCSpecialConst.h"
#define CORVERVIEWTAG 998
@implementation LCStatusTextView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        self.delegate = self;
        self.editable = NO;
        self.scrollEnabled = NO;
        self.backgroundColor = kBgWhiteColor;
        self.tintColor = [UIColor clearColor];
//        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    }
    return self;
}
- (void)setupSpecials{
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    for (LCSpecialTextModel *model  in specials) {
        self.selectedRange = model.range;
        NSArray *selectionsRects = [self selectionRectsForRange:self.selectedTextRange];
        NSMutableArray *rects = [NSMutableArray array];
        self.selectedRange = NSMakeRange(0, 0);

        for (UITextSelectionRect *selectionRect in selectionsRects) {
            if (selectionRect.rect.size.width == 0 || selectionRect.rect.size.height == 0) continue;
            [rects addObject:[NSValue valueWithCGRect:selectionRect.rect]];
        }
        model.rects = rects;
    }
    

}

- (LCSpecialTextModel *)touchSpecialPoint:(CGPoint)point{
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    for (LCSpecialTextModel *model  in specials) {
        for (NSValue *selectionRect in model.rects) {
            if (CGRectContainsPoint(selectionRect.CGRectValue, point)) {
                return model;
            }
  
        }

    }
    return nil;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self setupSpecials];

    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    
    LCSpecialTextModel *model = [self touchSpecialPoint:touchPoint];
    
    /**
     *  发送点击事件通知
     */
    [[NSNotificationCenter defaultCenter]postNotificationName:kPressSpecialTextNotification object:nil userInfo:@{kPressSpecialTextNotificationUserInfo:model}];
    
    for (NSValue *rectValue in model.rects) {
        UIView *coverView = [[UIView alloc]init];
        coverView.frame = [rectValue CGRectValue];
        coverView.backgroundColor = kBlueColor;
        coverView.tag  = CORVERVIEWTAG;
        [self insertSubview:coverView atIndex:0];
    }

}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.16 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
   }

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UIView *view in self.subviews) {
        if (view.tag == CORVERVIEWTAG) {
            [view removeFromSuperview];
        }
    }

}
#pragma mark --关闭复制等选项
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    
    //    UITextView *text=(UITextView *)sender;
    [UIMenuController sharedMenuController].menuVisible = NO;  //donot display the menu
    [self resignFirstResponder];                     //do not allow the user to selected anything
    return NO;
    
}

#pragma mark --事件处理
/**
 *  1.判断点在谁身上 调用所有UI控件的pointInside方法
    2.pointInside返回YES就是触摸点所在的UI控件
    3.告诉点击事件谁来处理
 */
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    [super hitTest:point withEvent:event];
//}

/**
 *  告诉系统:触摸点point是否在UI控件上
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    [self setupSpecials];

    LCSpecialTextModel *model = [self touchSpecialPoint:point];
    if (model) {
        return YES;
    }else{
        return NO;
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
