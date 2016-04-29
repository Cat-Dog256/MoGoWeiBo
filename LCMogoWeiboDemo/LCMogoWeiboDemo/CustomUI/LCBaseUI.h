//
//  LCBaseUI.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/24.
//  Copyright © 2016年 李策. All rights reserved.
//

#ifndef LCBaseUI_h
#define LCBaseUI_h
#import "LCView.h"
#import "LCLabel.h"
#import "LCButton.h"


#import "LCView_LineMethodHeader.h"
#pragma mark 下面的宏用来添加控件的上边线和下边线的代码块
//line属性声明
#define kLineAttributeDeclarations \
\
@property (nonatomic,weak) UIView *topLineV; \
@property (nonatomic,weak) UIView *downLineV; \
\
@property (nonatomic,assign) CGFloat top_topMargin; \
@property (nonatomic,assign) CGFloat top_leftMargin; \
@property (nonatomic,assign) CGFloat top_rightMargin; \
\
@property (nonatomic,assign) CGFloat down_downMargin; \
@property (nonatomic,assign) CGFloat down_leftMargin; \
@property (nonatomic,assign) CGFloat down_rightMargin; \
\
@property (nonatomic,assign) CGFloat topLineHeight; \
@property (nonatomic,assign) CGFloat downLineHeight; \
\
@property (nonatomic,strong) UIColor *topLineColor; \
@property (nonatomic,strong) UIColor *downLineColor; \
\
\
\
@property (nonatomic,weak) UIView *leftLineV; \
@property (nonatomic,weak) UIView *rightLineV; \
\
@property (nonatomic,assign) CGFloat left_leftMargin; \
@property (nonatomic,assign) CGFloat left_topMargin; \
@property (nonatomic,assign) CGFloat left_downMargin; \
\
@property (nonatomic,assign) CGFloat right_rightMargin; \
@property (nonatomic,assign) CGFloat right_topMargin; \
@property (nonatomic,assign) CGFloat right_downMargin; \
\
@property (nonatomic,assign) CGFloat leftLineWidth; \
@property (nonatomic,assign) CGFloat rightLineWidth; \
\
@property (nonatomic,strong) UIColor *leftLineColor; \
@property (nonatomic,strong) UIColor *rightLineColor;

//line方法实现
#define kLineMethodImplementation \
\
- (void)setTop_topMargin:(CGFloat)top_topMargin{ \
_top_topMargin = top_topMargin; \
[self layoutIfNeeded]; \
} \
- (void)setTop_leftMargin:(CGFloat)top_leftMargin{ \
_top_leftMargin = top_leftMargin; \
[self layoutIfNeeded]; \
} \
- (void)setTop_rightMargin:(CGFloat)top_rightMargin{ \
_top_rightMargin = top_rightMargin; \
[self layoutIfNeeded]; \
} \
\
- (void)setTopLineHeight:(CGFloat)topLineHeight{ \
_topLineHeight = topLineHeight; \
self.topLineV.height = topLineHeight; \
[self layoutIfNeeded]; \
} \
\
- (void)setDownLineHeight:(CGFloat)downLineHeight{ \
_downLineHeight = downLineHeight; \
self.downLineV.height = downLineHeight; \
[self layoutIfNeeded]; \
} \
\
- (void)setTopLineColor:(UIColor *)topLineColor{ \
_topLineColor = topLineColor; \
self.topLineV.backgroundColor = topLineColor; \
} \
- (void)setDownLineColor:(UIColor *)downLineColor{ \
_downLineColor = downLineColor; \
self.downLineV.backgroundColor = downLineColor; \
} \
\
- (void)addTopLineWithTopMargin:(CGFloat)top_topMargin leftMargin:(CGFloat)top_leftMargin rightMargin:(CGFloat)top_rightMargin{ \
\
self.top_topMargin = top_topMargin; \
self.top_leftMargin = top_leftMargin; \
self.top_rightMargin = top_rightMargin; \
\
UIView *topLineV = [self lineV]; \
[self addSubview:topLineV]; \
self.topLineV = topLineV; \
} \
- (void)addDownLineWithDownMargin:(CGFloat)down_downMargin leftMargin:(CGFloat)down_leftMargin rightMargin:(CGFloat)down_rightMargin{ \
\
self.down_downMargin = down_downMargin; \
self.down_leftMargin = down_leftMargin; \
self.down_rightMargin = down_rightMargin; \
\
UIView *downLineV = [self lineV]; \
[self addSubview:downLineV]; \
self.downLineV = downLineV; \
} \
\
\
\
\
- (void)setLeft_leftMargin:(CGFloat)left_leftMargin{ \
_left_leftMargin = left_leftMargin; \
[self layoutIfNeeded]; \
} \
- (void)setLeft_topMargin:(CGFloat)left_topMargin{ \
_left_topMargin = left_topMargin; \
[self layoutIfNeeded]; \
} \
- (void)setLeft_downMargin:(CGFloat)left_downMargin{ \
_left_downMargin = left_downMargin; \
[self layoutIfNeeded]; \
} \
\
- (void)setLeftLineWidth:(CGFloat)leftLineWidth{ \
_leftLineWidth = leftLineWidth; \
self.leftLineV.width = leftLineWidth; \
[self layoutIfNeeded]; \
} \
\
- (void)setRightLineWidth:(CGFloat)rightLineWidth{ \
_rightLineWidth = rightLineWidth; \
self.rightLineV.width = rightLineWidth; \
[self layoutIfNeeded]; \
} \
\
- (void)setLeftLineColor:(UIColor *)leftLineColor{ \
_leftLineColor = leftLineColor; \
self.leftLineV.backgroundColor = leftLineColor; \
} \
- (void)setRightLineColor:(UIColor *)rightLineColor{ \
_rightLineColor = rightLineColor; \
self.rightLineV.backgroundColor = rightLineColor; \
} \
\
- (void)addLeftLineWithLeftMargin:(CGFloat)left_leftMargin topMargin:(CGFloat)left_topMargin downMargin:(CGFloat)left_downMargin{ \
\
self.left_leftMargin = left_leftMargin; \
self.left_topMargin = left_topMargin; \
self.left_downMargin = left_downMargin; \
\
UIView *leftLineV = [self lineV]; \
[self addSubview:leftLineV]; \
self.leftLineV = leftLineV; \
} \
- (void)addRightLineWithRightMargin:(CGFloat)right_rightMargin topMargin:(CGFloat)right_topMargin downMargin:(CGFloat)right_downMargin{ \
\
self.right_rightMargin = right_rightMargin; \
self.right_topMargin = right_topMargin; \
self.right_downMargin = right_downMargin; \
\
UIView *rightLineV = [self lineV]; \
[self addSubview:rightLineV]; \
self.rightLineV = rightLineV; \
}



//line坐标计算
#define kLineCalculationPosition \
\
self.topLineV.frame = CGRectMake(self.top_leftMargin, self.top_topMargin, self.width-self.top_leftMargin-self.top_rightMargin, self.topLineV.height); \
\
self.downLineV.frame = CGRectMake(self.down_leftMargin, self.height-self.downLineV.height-self.down_downMargin,self.width-self.down_leftMargin-self.down_rightMargin,self.downLineV.height); \
\
\
\
self.leftLineV.frame = CGRectMake(self.left_leftMargin, self.left_topMargin, self.leftLineV.width, self.height-self.left_topMargin-self.left_downMargin); \
\
self.rightLineV.frame = CGRectMake(self.width-self.right_rightMargin-self.rightLineV.width, self.right_topMargin, self.rightLineV.width, self.height-self.right_topMargin-self.right_downMargin);


#endif /* LCBaseUI_h */
