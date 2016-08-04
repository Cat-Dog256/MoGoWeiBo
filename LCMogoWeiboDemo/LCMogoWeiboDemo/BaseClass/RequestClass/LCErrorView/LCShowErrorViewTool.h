//
//  LCShowErrorViewTool.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    kRefreshStyleDrapDown,//重新下拉进行刷新
    kRefreshStyleBtnClick//点击按钮进行刷新
}RefreshStyle;

@class LCShowErrorViewTool;


@protocol LCShowErrorViewToolDelegate <NSObject>
/**
 *  备用
 *
 *  @param showErrorViewTool ErrorToolView
 */
- (void)showErrorViewToolForBtnClick:(LCShowErrorViewTool *)showErrorViewTool;

@end


@interface LCShowErrorViewTool : NSObject
//属性
@property (nonatomic,weak) id<LCShowErrorViewToolDelegate> delegate;

//网络断开相关-------------------------------------------------------------------
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
- (void)showNetBreakIn:(UIView *)contentV refreshStyle:(RefreshStyle)state showHeader:(BOOL)showHeader showFooter:(BOOL)showFooter showFrame:(CGRect)rect refreshBlock:(void(^)())refreshBlock;
/**
 *  隐藏网络断开异常界面
 *  @param view 从那个view移除
 */
- (void)hiddenNetBreakFrom:(UIView *)view;


//加载失败相关----------------------------------------------------------------------
/**
 *  显示加载失败界面
 *
 *  @param contentV 界面的父视图
 *  @param rect     错误界面的frame
 */
- (void)showLoadFaildIn:(UIView *)contentV showFrame:(CGRect)rect refreshBlock:(void(^)())refreshBlock;
- (void)hiddenLoadFaildFrom:(UIView *)view;

@end
