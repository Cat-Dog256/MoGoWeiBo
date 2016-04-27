//
//  LCTableViewCell.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/25.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCTableViewCell.h"

@interface LCTableViewCell ()
kLineAttributeDeclarations
@end

@implementation LCTableViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

//重新修改线的位置
- (void)setTop_topMargin:(CGFloat)top_topMargin{
    _top_topMargin = top_topMargin;
    [self layoutIfNeeded];
}
- (void)setTop_leftMargin:(CGFloat)top_leftMargin{
    _top_leftMargin = top_leftMargin;
    [self layoutIfNeeded];
}
- (void)setTop_rightMargin:(CGFloat)top_rightMargin{
    _top_rightMargin = top_rightMargin;
    [self layoutIfNeeded];
}

//设置线高度
- (void)setTopLineHeight:(CGFloat)topLineHeight{
    _topLineHeight = topLineHeight;
    self.topLineV.height = topLineHeight;
    [self layoutIfNeeded];
}
- (void)setDownLineHeight:(CGFloat)downLineHeight{
    _downLineHeight = downLineHeight;
    self.downLineV.height = downLineHeight;
    [self layoutIfNeeded];
}

//设置线颜色
- (void)setTopLineColor:(UIColor *)topLineColor{
    _topLineColor = topLineColor;
    self.topLineV.backgroundColor = topLineColor;
}
- (void)setDownLineColor:(UIColor *)downLineColor{
    _downLineColor = downLineColor;
    self.downLineV.backgroundColor = downLineColor;
}

//添加上边线
- (void)addTopLineWithTopMargin:(CGFloat)top_topMargin leftMargin:(CGFloat)top_leftMargin rightMargin:(CGFloat)top_rightMargin{
    
    self.top_topMargin = top_topMargin;
    self.top_leftMargin = top_leftMargin;
    self.top_rightMargin = top_rightMargin;
    
    UIView *topLineV = [self lineV];
    [self addSubview:topLineV];
    self.topLineV = topLineV;
}
//添加下边线
- (void)addDownLineWithDownMargin:(CGFloat)down_downMargin leftMargin:(CGFloat)down_leftMargin rightMargin:(CGFloat)down_rightMargin{
    
    self.down_downMargin = down_downMargin;
    self.down_leftMargin = down_leftMargin;
    self.down_rightMargin = down_rightMargin;
    
    UIView *downLineV = [self lineV];
    [self addSubview:downLineV];
    self.downLineV = downLineV;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.topLineV.frame = CGRectMake(self.top_leftMargin, self.top_topMargin, self.contentView.width-self.top_leftMargin-self.top_rightMargin, self.topLineV.height);
    
    self.downLineV.frame = CGRectMake(self.down_leftMargin, self.height-self.downLineV.height-self.down_downMargin,self.contentView.width-self.down_leftMargin-self.down_rightMargin,self.downLineV.height);
    
}


@end
