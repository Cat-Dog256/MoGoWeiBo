//
//  UIScrollView+LCRefresh.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface UIScrollView (LCRefresh)
/**
 block中放下啦刷新要做的操作
 */
- (void)addRefreshHeader:(void(^)())headerRefreshBlock;
- (void)removeRefreshHeader;

/**
 block中放上啦刷新要做的操作
 */
- (void)addRefreshFooter:(void(^)())footerRefreshBlock;
- (void)removeRefreshFooter;


//- (void)setImages:(NSArray *)images;
//- (NSArray *)getImages:(NSString *)gifImageName;
//
@end
