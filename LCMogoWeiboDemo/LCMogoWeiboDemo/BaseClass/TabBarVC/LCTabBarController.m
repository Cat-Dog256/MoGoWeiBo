//
//  LCTabBarController.m
//  MoGoWeiBo
//
//  Created by 李策 on 16/4/7.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCTabBarController.h"
@interface LCTabBarController ()

@end

@implementation LCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)addChildVC:(UIViewController *)childController normalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage tabBarTitle:(NSString *)tabBartitle {
    /**
     *  未选中时的图片
     */
    childController.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//以原图颜色渲染
    /**
     *  选中时的图片
     */
    childController.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    /**
     *  未选中时的字体大小颜色
     */
    
    NSMutableDictionary *normallAttri = [NSMutableDictionary dictionary];
    normallAttri[NSFontAttributeName] = self.titleFont;
    normallAttri[NSForegroundColorAttributeName] = self.titleNormallColor;
    [childController.tabBarItem setTitleTextAttributes:normallAttri forState:UIControlStateNormal];
    /**
     *  选中时的字体颜色大小
     */
    NSMutableDictionary *selectedAttri = [NSMutableDictionary dictionary];
    selectedAttri[NSFontAttributeName] = self.titleFont;
    selectedAttri[NSForegroundColorAttributeName] = self.titleSelectedColor;
    [childController.tabBarItem setTitleTextAttributes:selectedAttri forState:UIControlStateSelected];
    
    childController.tabBarItem.title = tabBartitle;

    /**
     *  把VC加到TabBarController
     */
    [self addChildViewController:childController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
