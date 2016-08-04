//
//  LCShowErrorViewTool.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCShowErrorViewTool.h"
#import "MJRefresh.h"
#import "UIScrollView+LCRefresh.h"
#import "LCLoadFaildView.h"
#import "LCNetworkCutView.h"
@interface LCShowErrorViewTool ()
//是否需要记录
@property (nonatomic,assign) BOOL record;
//是否可以滑动的原来值
@property (nonatomic,assign) BOOL oriScrollEnable;
//记录header
@property (nonatomic,strong) MJRefreshComponent *myHeader;
//记录footer
@property (nonatomic,strong) MJRefreshComponent *myFooter;
@end

@implementation LCShowErrorViewTool
//默认通过下拉刷新来重新加载刷新界面
- (void)showLoadFaildIn:(UIView *)contentV showFrame:(CGRect)rect refreshBlock:(void(^)())refreshBlock{
    
    if([contentV isKindOfClass:[UITableView class]]){
        //需要显示到tableView上
        UITableView *myTabV = (UITableView *)contentV;
        
        //第一次进入这个界面的话记录table设置过的header和footer等
        if(!self.record){
            self.myHeader = myTabV.mj_header;
            self.myFooter = myTabV.mj_footer;
            self.oriScrollEnable = myTabV.scrollEnabled;
            self.record = YES;
        }
        
        //刷新tableView 移除tableView原先的下拉上啦效果，设置tableView不能滑动
        [myTabV reloadData];
        [myTabV removeRefreshHeader];
        [myTabV removeRefreshFooter];
        myTabV.scrollEnabled = NO;
        
        //加载视图
        LCLoadFaildView *faildV = [[LCLoadFaildView alloc] initWithFrame:rect];
        
        __weak LCLoadFaildView *weakfaildV = faildV;
        [faildV addRefreshHeader:^{
            //显示刷新中的效果
            [weakfaildV showRefreshAction];
            //执行block
            if(refreshBlock){
                refreshBlock();
            }
        }];
        
        //先移除原先的错误视图，再添加新的视图
        [self removeLoadFaildVFrom:myTabV];
        [myTabV addSubview:faildV];
        [myTabV bringSubviewToFront:faildV];
        
//        [faildV cancelRefreshAction];//加载完成后停止界面上得菊花转圈等效果
        
    }else{
        //需要显示到view
        
        //加载视图
        LCLoadFaildView *faildV = [[LCLoadFaildView alloc] initWithFrame:rect];
        
        __weak LCLoadFaildView *weakfaildV = faildV;
        [faildV addRefreshHeader:^{
            //显示刷新中的效果
            [weakfaildV showRefreshAction];
            //执行block
            if(refreshBlock){
                refreshBlock();
            }
        }];
        
        //先移除原先的错误视图，再添加新的视图
        [self removeLoadFaildVFrom:contentV];
        [contentV addSubview:faildV];
        [contentV bringSubviewToFront:faildV];
        
        [faildV cancelRefreshAction];//加载完成后停止界面上得菊花转圈等效果
    }
}
- (void)hiddenLoadFaildFrom:(UIView *)view{
    
    if([view isKindOfClass:[UITableView class]]){
        //是tableView
        UITableView *myTabV = (UITableView *)view;
        
        //如果已经是记录过的属性，才有机会还原
        if(self.record){
            //还原是否可以滑动
            UIViewController *curVc = [self getViewControllerWith:view];
            CGFloat navBarH = curVc.navigationController.navigationBar.height;
            myTabV.contentOffset = CGPointMake(0, -navBarH-20);//20是状态栏的高度
            myTabV.scrollEnabled = self.oriScrollEnable;
            
            //还原之前的header和footer
            myTabV.mj_header = (MJRefreshHeader *)self.myHeader;
            myTabV.mj_footer = (MJRefreshFooter *)self.myFooter;
        }
        
        [myTabV reloadData];
        
    }else{
        //普通view
    }
    [self removeLoadFaildVFrom:view];
}
- (void)removeLoadFaildVFrom:(UIView *)view{
    
    for (UIView *v in view.subviews) {
        if([v isKindOfClass:[LCLoadFaildView class]]){
            [v removeFromSuperview];
        }
    }
}

//加载失败显示相关(后台返回异常服务码)--------↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑-------------//




//网络断开显示相关--------↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓--------------------//
//显示到view上
- (void)showNetBreakIn:(UIView *)contentV refreshStyle:(RefreshStyle)state showHeader:(BOOL)showHeader showFooter:(BOOL)showFooter showFrame:(CGRect)rect refreshBlock:(void(^)())refreshBlock{
    
    if([contentV isKindOfClass:[UITableView class]]){
        //需要显示到tableView上
        
        UITableView *myTabV = (UITableView *)contentV;
        
        //第一次进入这个界面的话记录table设置过的header和footer等
        if(!self.record){
            self.myHeader = myTabV.mj_header;
            self.myFooter = myTabV.mj_footer;
            self.oriScrollEnable = myTabV.scrollEnabled;
            self.record = YES;
        }
        
        //刷新tableView 移除tableView原先的下拉上拉效果，设置tableView不能滑动
        [myTabV reloadData];
        [myTabV removeRefreshHeader];
        [myTabV removeRefreshFooter];
        myTabV.scrollEnabled = NO;
        
        //开始选择用什么效果的错误界面
        LCNetworkCutView *cutV = nil;
        
        if(state == kRefreshStyleDrapDown){
            //下拉效果
            cutV = [LCNetworkCutView networkCutVWithScrollState:rect];
            
            if(showHeader){
                
                __weak LCNetworkCutView *weakCutV = cutV;
                [cutV addRefreshHeader:^{
                    //显示刷新中的效果
                    [weakCutV showRefreshAction];
                    //执行block
                    if(refreshBlock){
                        refreshBlock();
                    }
                }];
            }
            if(showFooter){
                
            }
        }
        
        if(state == kRefreshStyleBtnClick){
            //按钮点击效果
            cutV = [LCNetworkCutView networkCutVWithBtnState:rect clickBlock:refreshBlock];
        }
        
        //先移除原先的错误视图，再添加新的视图
        [self removeErrorMsgVFrom:myTabV];
        [myTabV addSubview:cutV];
        [myTabV bringSubviewToFront:cutV];
        
        [cutV cancelRefreshAction];//加载完成后停止界面上得菊花转圈等效果
        
        
    }else{
        //需要显示到view
        
        LCNetworkCutView *cutV = nil;
        
        if(state == kRefreshStyleBtnClick){
            cutV = [LCNetworkCutView networkCutVWithBtnState:rect clickBlock:refreshBlock];
        }
        
        if(state == kRefreshStyleDrapDown){
            
            cutV = [LCNetworkCutView networkCutVWithScrollState:rect];
            
            if(showHeader){
                
                __weak LCNetworkCutView *weakCutV = cutV;
                [cutV addRefreshHeader:^{
                    //显示刷新中的效果
                    [weakCutV showRefreshAction];
                    //执行block
                    if(refreshBlock){
                        refreshBlock();
                    }
                }];
            }
            if(showFooter){
                
            }
        }
        
        //先移除原先的错误视图，再添加新的视图
        [self removeErrorMsgVFrom:contentV];
        [contentV addSubview:cutV];
        [contentV bringSubviewToFront:cutV];
        
        [cutV cancelRefreshAction];//加载完成后停止界面上得菊花转圈等效果
    }
    
}


//成功时：影藏错误界面
- (void)hiddenNetBreakFrom:(UIView *)view{
    
    if([view isKindOfClass:[UITableView class]]){
        //是tableView
        UITableView *myTabV = (UITableView *)view;
        
        //如果已经是记录过的属性，才有机会还原
        if(self.record){
            //还原是否可以滑动
            UIViewController *curVc = [self getViewControllerWith:view];
            CGFloat navBarH = curVc.navigationController.navigationBar.height;
            myTabV.contentOffset = CGPointMake(0, -navBarH-20);//20是状态栏的高度
            myTabV.scrollEnabled = self.oriScrollEnable;
            
            //还原之前的header和footer
            myTabV.mj_header = (MJRefreshHeader *)self.myHeader;
            myTabV.mj_footer = (MJRefreshFooter *)self.myFooter;
        }
        
        [myTabV reloadData];
        
    }else{
        //普通view
    }
    [self removeErrorMsgVFrom:view];
}

//取得view所在的控制器
- (UIViewController*)getViewControllerWith:(UIView *)view{
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

//移除错误显示的控件
- (void)removeErrorMsgVFrom:(UIView *)view{
    
    for (UIView *v in view.subviews) {
        if([v isKindOfClass:[LCNetworkCutView class]]){
            [v removeFromSuperview];
        }
    }
}
@end
