//
//  LCTabBarController.h
//  MoGoWeiBo
//
//  Created by 李策 on 16/4/7.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCTabBarController : UITabBarController
/**
 *  title的字体大小
 */
@property (nonatomic , strong) UIFont *titleFont;
/**
 *  title未选中的字体颜色
 */
@property (nonatomic , strong) UIColor *titleNormallColor;
/**
 *  title选中的字体颜色
 */
@property (nonatomic , strong) UIColor *titleSelectedColor;
/**
 *  为TabBar添加Viewcontroller
 *
 *  @param childController VC
 *  @param normalImageName 未选中的图片
 *  @param selectImageName 选中的图片
 *  @param tabBartitle     VC的标题
 */
- (void)addChildVC:(UIViewController *)childController normalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage tabBarTitle:(NSString *)tabBartitle;
@end
