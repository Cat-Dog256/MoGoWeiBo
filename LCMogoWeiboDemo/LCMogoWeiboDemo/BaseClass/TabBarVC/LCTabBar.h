//
//  LCTabBar.h
//  MoGoWeiBo
//
//  Created by 李策 on 16/4/7.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCTabBar;
@protocol LCTabBarDelegate <UITabBarDelegate,NSObject>

- (void)tabBarDidClickPlusButton:(LCTabBar *)tabBar;

@end

@interface LCTabBar : UITabBar
@property (nonatomic ,weak) id<LCTabBarDelegate>tabBar_delegate;

@end
