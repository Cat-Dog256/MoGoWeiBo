//
//  LCLoadFaildView.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//
#import "UIColor+Extension.h"
#import "LCLoadFaildView.h"
//背景灰色
#define kBgDarkColor [UIColor colorWithHexString:@"#efefef" alpha:1]
//中性黑 用于灰色
#define kMidBlackColor [UIColor colorWithHexString:@"#707070" alpha:1]

@interface LCLoadFaildView ()
@property (nonatomic,weak) UIView *backV;

@property (nonatomic,weak) UIImageView *imgV;

@property (nonatomic,weak) UILabel *promptL;

@property (nonatomic,weak) UIActivityIndicatorView *aci;

@end

@implementation LCLoadFaildView
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        UIView *backV = [[UIView alloc] init];
        backV.backgroundColor = kBgDarkColor;
        [self addSubview:backV];
        self.backV = backV;
        
        //提示图片
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loadFaild_pic"]];
        [self.backV addSubview:imgV];
        self.imgV = imgV;
        
        //提示语言
        UILabel *promptL = [[UILabel alloc] init];
        promptL.text = @"啊哦~加载失败!";
        promptL.textColor = kMidBlackColor;
        promptL.font = [UIFont systemFontOfSize:18];
        [promptL sizeToFit];
        [self.backV addSubview:promptL];
        self.promptL = promptL;
        
        //菊花
        UIActivityIndicatorView *aci = [[UIActivityIndicatorView alloc] init];
        aci.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        aci.hidesWhenStopped = YES;
        [self.backV addSubview:aci];
        self.aci = aci;
    }
    return self;
}

//开始刷新效果
- (void)showRefreshAction{
    [self.aci startAnimating];
}
//取消刷新效果
- (void)cancelRefreshAction{
    [self.aci stopAnimating];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.backV.frame = CGRectMake(0, 0, self.width, self.height);
    
    CGFloat imgVX = (self.width-self.imgV.width)*0.5;
    CGFloat imgVY = 150;
    self.imgV.frame = CGRectMake(imgVX, imgVY, self.imgV.width, self.imgV.height);
    
    CGFloat promptLX = (self.width-self.promptL.width)*0.5;
    CGFloat promptLY = CGRectGetMaxY(self.imgV.frame)+30;
    self.promptL.frame = CGRectMake(promptLX, promptLY, self.promptL.width, self.promptL.height);
    
    self.aci.frame = CGRectMake((self.width-40)*0.5, CGRectGetMaxY(self.promptL.frame)+10, 40, 40);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
