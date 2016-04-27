//
//  LCBaseViewController.h
//  MoGoWeiBo
//
//  Created by 李策 on 16/4/7.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCShowErrorViewTool.h"
#import "LCExceptionConst.h"
#import "LCBaseReformer.h"
//所用VC的父类


@interface LCBaseViewController : UIViewController<LCBaseReformerDelegate>
//错误页面管理者
@property (nonatomic, strong) LCShowErrorViewTool *showTool;

- (void)netStateChangedMessage:(NSString *)netState;
/**
 *  显示网络断开的异常界面
 *
 *  @param container    界面的父视图
 *  @param style        刷新样式提供两种：1、上下拉，2、点击按钮
 *  @param showHeader   刷新样式中 是否显示头部动画
 *  @param showfooter   刷新样式中 是否显示底部动画
 *  @param showFrame    错误界面的frame
 *  @param refreshBlock 点击或者下拉刷新调用的block
 */
- (void)showNetExceptionOn:(UIView *)container
              refreshStyle:(RefreshStyle)style
                showHeader:(BOOL)showHeader
                showFooter:(BOOL)showfooter
                 showFrame:(CGRect)showFrame
              refreshBlock:(void(^)())refreshBlock;
/**
 *  显示加载失败的异常界面
 *
 *  @param container    界面的父视图
 *  @param showFrame    错误界面的frame
 *  @param refreshBlock 点击或者下拉刷新调用的block
 */
- (void)showLoadFaildIn:(UIView *)contentV showFrame:(CGRect)rect refreshBlock:(void(^)())refreshBlock;
/**
 *  移除异常界面
 *
 *  @param container 异常界面的父视图
 */
- (void)removeExceptionFrom:(UIView *)container;
/**
 *  显示弹出框
 *
 *  @param mes  显示内容
 *  @param time 消失时间
 */
- (void)showHudMes:(NSString *)mes hiddenDelay:(CGFloat)time;

@end
