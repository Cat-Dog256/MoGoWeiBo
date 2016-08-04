//
//  LCView_LineMethodHeader.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/25.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView ()
//上下线的添加----------------??>>>>

//添加上边线
- (void)addTopLineWithTopMargin:(CGFloat)top_topMargin leftMargin:(CGFloat)top_leftMargin rightMargin:(CGFloat)top_rightMargin;

//添加下边线
- (void)addDownLineWithDownMargin:(CGFloat)down_downMargin leftMargin:(CGFloat)down_leftMargin rightMargin:(CGFloat)down_rightMargin;

//设置线高度
- (void)setTopLineHeight:(CGFloat)topLineHeight;
- (void)setDownLineHeight:(CGFloat)downLineHeight;

//设置线颜色
- (void)setTopLineColor:(UIColor *)topLineColor;
- (void)setDownLineColor:(UIColor *)downLineColor;



//左右线的添加----------------?>>>>>

//添加左边线
- (void)addLeftLineWithLeftMargin:(CGFloat)left_leftMargin topMargin:(CGFloat)left_topMargin downMargin:(CGFloat)left_downMargin;
//添加右边线
- (void)addRightLineWithRightMargin:(CGFloat)right_rightMargin topMargin:(CGFloat)right_topMargin downMargin:(CGFloat)right_downMargin;

//设置线宽度
- (void)setLeftLineWidth:(CGFloat)leftLineWidth;
- (void)setRightLineWidth:(CGFloat)rightLineWidth;

//设置线颜色
- (void)setLeftLineColor:(UIColor *)leftLineColor;
- (void)setRightLineColor:(UIColor *)rightLineColor;

@end
