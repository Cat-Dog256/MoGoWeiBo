//
//  LCNetworkCutView.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//
#define kBGColor  DDMakeColor(240, 239, 245)

#import "LCNetworkCutView.h"
@interface LCNetworkCutView ()

@property (nonatomic,weak) UIView *backV;
@property (nonatomic,weak) UIImageView *imgV;
@property (nonatomic,weak) UILabel *errorLab;
@property (nonatomic,weak) UIActivityIndicatorView *aci;

@property (nonatomic,weak) UILabel *refreshLab;

@property (nonatomic,weak) UIButton *refreshBtn;
@property (nonatomic,copy) void(^clickBlock)();

@end

@implementation LCNetworkCutView
/**
 *  @param rect 要显示的范围
 */
+ (instancetype)networkCutVWithScrollState:(CGRect)rect{
    LCNetworkCutView *cutV = [[LCNetworkCutView alloc] initWithFrame:rect];
    
    UILabel *refreshLab = [[UILabel alloc] init];
    refreshLab.text = @"下拉刷新重试";
    refreshLab.textAlignment= NSTextAlignmentCenter;
    refreshLab.textColor = [UIColor darkGrayColor];
    refreshLab.numberOfLines = 0;
    refreshLab.font = [UIFont systemFontOfSize:14];
    [cutV.backV addSubview:refreshLab];
    cutV.refreshLab = refreshLab;
    
    return cutV;
}

/**
 *  @param rect 要显示的范围
 *  @param clickBlock 点击后要执行的操作
 */
+ (instancetype)networkCutVWithBtnState:(CGRect)rect clickBlock:(void(^)())clickBlock{
    
    LCNetworkCutView *cutV = [[LCNetworkCutView alloc] initWithFrame:rect];
    
    cutV.clickBlock = clickBlock;
    
    //添加刷新按钮
    UIButton *refreshBtn = [[UIButton alloc] init];
    refreshBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [refreshBtn setTitle:@"点击刷新" forState:UIControlStateNormal];
    [refreshBtn setTitle:@"刷新中..." forState:UIControlStateDisabled];
    [refreshBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    refreshBtn.backgroundColor = [UIColor lightGrayColor];
    [refreshBtn sizeToFit];
    [cutV.backV addSubview:refreshBtn];
    cutV.refreshBtn = refreshBtn;
    [refreshBtn addTarget:cutV action:@selector(refreshBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    return cutV;
}

#pragma mark 刷新按钮点击事件
- (void)refreshBtnClick{
    
    [self showRefreshAction];
    
    if(self.clickBlock){
        self.clickBlock();
    }
}

//开始刷新效果
- (void)showRefreshAction{
    self.refreshBtn.enabled = NO;
    self.refreshLab.text = @"刷新中...";
    [self.aci startAnimating];
}
//取消刷新效果
- (void)cancelRefreshAction{
    self.refreshBtn.enabled = YES;
    self.refreshLab.text = @"下拉刷新重试";
    [self.aci stopAnimating];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *backV = [[UIView alloc] init];
        backV.backgroundColor = kBGColor;
        [self addSubview:backV];
        self.backV = backV;
        
        UIImageView *imgV = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"no_Net_pic"];
        imgV.image = image;
        [self.backV addSubview:imgV];
        self.imgV = imgV;
        
        UILabel *errorLab = [[UILabel alloc] init];
        errorLab.text = @"您当前网络不佳,请稍后重试";
        errorLab.textAlignment= NSTextAlignmentCenter;
        errorLab.textColor = [UIColor darkGrayColor];
        errorLab.numberOfLines = 0;
        errorLab.font = [UIFont systemFontOfSize:15];
        [self.backV addSubview:errorLab];
        self.errorLab = errorLab;
        
        UIActivityIndicatorView *aci = [[UIActivityIndicatorView alloc] init];
        aci.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        aci.hidesWhenStopped = YES;
        [self.backV addSubview:aci];
        self.aci = aci;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.backV.frame = CGRectMake(0, 0, self.width, self.height);
    
    CGFloat margin = 20;
    
    CGFloat imgVW = 100;
    CGFloat imgVH = 100;
    CGFloat imgVX = (self.width-imgVW)*0.5;
    CGFloat imgVY = self.height*0.15;
    self.imgV.frame = CGRectMake(imgVX, imgVY, imgVW, imgVH);
    
    CGFloat errorLabW = 120;
    self.errorLab.width = errorLabW;
    [self.errorLab sizeToFit];
    CGFloat errorLabX = (self.width-errorLabW)*0.5;
    CGFloat errorLabY = CGRectGetMaxY(self.imgV.frame)+margin;
    self.errorLab.frame = CGRectMake(errorLabX, errorLabY, errorLabW, self.errorLab.height);
    
    
    CGFloat aciW = 40;
    CGFloat aciH = aciW;
    CGFloat aciX = (self.width-aciW)*0.5;
    
    if(self.refreshLab){
        CGFloat refreshLabW = 100;
        self.refreshLab.width = refreshLabW;
        [self.refreshLab sizeToFit];
        CGFloat refreshLabX = (self.width-refreshLabW)*0.5;
        CGFloat refreshLabY = CGRectGetMaxY(self.errorLab.frame)+margin;
        self.refreshLab.frame = CGRectMake(refreshLabX, refreshLabY, refreshLabW, self.refreshLab.height);
        
        self.aci.frame = CGRectMake(aciX, CGRectGetMaxY(self.refreshLab.frame)+margin, aciW, aciH);
    }
    if(self.refreshBtn){
        CGFloat refreshBtnX = (self.width-self.refreshBtn.width)*0.5;
        CGFloat refreshBtnY = CGRectGetMaxY(self.errorLab.frame)+margin;
        self.refreshBtn.frame = CGRectMake(refreshBtnX, refreshBtnY, self.refreshBtn.width, self.refreshBtn.height);
        
        self.aci.frame = CGRectMake(aciX, CGRectGetMaxY(self.refreshBtn.frame)+margin, aciW, aciH);
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
