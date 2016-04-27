//
//  LCNetworkCutView.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCNetworkCutView : UIScrollView
- (void)showRefreshAction;
- (void)cancelRefreshAction;

//错误界面可以下拉刷新
+ (instancetype)networkCutVWithScrollState:(CGRect)rect;

//错误界面可以点击刷新
+ (instancetype)networkCutVWithBtnState:(CGRect)rect clickBlock:(void(^)())clickBlock;
@end
