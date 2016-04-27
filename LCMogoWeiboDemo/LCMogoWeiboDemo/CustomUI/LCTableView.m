//
//  LCTableIView.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/24.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCTableView.h"

@interface LCTableView ()
//提示语L
@property (nonatomic,weak) UILabel *promptL;
//提示图片V
@property (nonatomic,weak) UIImageView *imgV;
@end

@implementation LCTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if(self = [super initWithFrame:frame style:style]){
        
        self.backgroundColor = kBgWhiteColor;
        
        UILabel *promptL = [[UILabel alloc] init];
        promptL.tag = 1314520;
        promptL.textColor = kMidBlackColor;
        promptL.font = [UIFont systemFontOfSize:18];
        promptL.hidden = YES;
        [promptL sizeToFit];
        [self addSubview:promptL];
        self.promptL = promptL;
        
        
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.hidden = YES;
        imgV.tag = 1314521;
        [self addSubview:imgV];
        self.imgV = imgV;
        
    }
    return self;
}


//自主控制是否允许显示空界面
- (void)setIsAllowShowNullView:(BOOL)isAllowShowNullView{
    _isAllowShowNullView = isAllowShowNullView;
    
    if(isAllowShowNullView){
        self.promptL.hidden = NO;
        self.imgV.hidden = NO;
    }else{
        self.promptL.hidden = YES;
        self.imgV.hidden = YES;
    }
}

- (void)reloadData{
    [super reloadData];
    [self judgeCurDataIsNull];
}

//判断是否为空内容，为空的话就给提示语
- (void)judgeCurDataIsNull{
    
    if([self isShowPromptL]){
        
        self.promptL.text = self.promptStr;
        [self.promptL sizeToFit];
        
        self.imgV.image = self.promptImage;
        [self.imgV sizeToFit];
        
        if(self.isAllowShowNullView){
            self.promptL.hidden = NO;
            self.imgV.hidden = NO;
        }
        
    }else{
        
        self.promptL.hidden = YES;
        self.imgV.hidden = YES;
    }
}

- (BOOL)isShowPromptL{
    for(int i=0; i<self.numberOfSections; i++){
        if([self numberOfRowsInSection:i] != 0){
            return NO;
        }
    }
    return YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    kLineCalculationPosition
    
    CGFloat imgVX = (self.width-self.imgV.width)*0.5;
    CGFloat imgVY = (SCREEN_HEIGHT-64)*(1/3.5);
    self.imgV.frame = CGRectMake(imgVX, imgVY, self.imgV.width, self.imgV.height);
    
    CGFloat promptLX = (self.width-self.promptL.width)*0.5;
    CGFloat promptLY = CGRectGetMaxY(self.imgV.frame)+30;
    self.promptL.frame = CGRectMake(promptLX, promptLY, self.promptL.width, self.promptL.height);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
