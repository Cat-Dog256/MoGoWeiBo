//
//  YGTLoginNavgationController.m
//  sunshineTeacher
//
//  Created by MoGo on 16/6/12.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "YGTLoginNavgationController.h"
#import "YGTNavConfiguration.h"
@interface YGTLoginNavgationController ()

@end

@implementation YGTLoginNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark**设置导航栏的主题  背景色，字体颜色，大小 ，主题色，只需设置一次**
+(void)initialize{
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemNormalDict = [[NSMutableDictionary alloc]init];
    itemNormalDict[NSForegroundColorAttributeName] = kNavgationbarItemTextColor;
    itemNormalDict[NSFontAttributeName] = kNavgationbarItemTextFont;
    /**
     *  按钮文字的配置
     */
    [item setTitleTextAttributes:itemNormalDict forState:UIControlStateNormal];
    
    
    //按钮不能点击的颜色
    NSMutableDictionary *itemDisabledDict = [[NSMutableDictionary alloc]init];
    itemDisabledDict[NSForegroundColorAttributeName] = kNavgationbarItemDisabledTextColor;
    itemDisabledDict[NSFontAttributeName] = kNavgationbarItemTextFont;
    [item setTitleTextAttributes:itemDisabledDict forState:UIControlStateDisabled];
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    /**
     设置导航栏title的字体信息
     */
    NSMutableDictionary *navTitleDict = [[NSMutableDictionary alloc]init];
    navTitleDict[NSForegroundColorAttributeName] = kLoginNavgationbarTitleTextColor;
    navTitleDict[NSFontAttributeName] = kNavgationbarTitleTextFont;
    [navBar setTitleTextAttributes:navTitleDict];
    
    /**
     *  一旦你设置了navigationBar的- (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics接口，那么上面的setBarTintColor接口就不能改变statusBar的背景色，statusBar的背景色就会变成纯黑色。
     */
    //    [navBar setBackgroundImage:[UIImage imageNamed:@"navBackground"] forBarMetrics:UIBarMetricsDefault];
    //  设置透明的导航栏
    //    [navBar setBackgroundImage:[self imageWithBgColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]] forBarMetrics:UIBarMetricsDefault];
    // 设置阴影线为透明
    //    [navBar setShadowImage:[self imageWithBgColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]]];
    
    
    
#pragma mark**导航栏颜色,这个会让状态栏和导航栏的颜色一样**
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    navBar.barStyle = UIStatusBarStyleDefault;
    [navBar setTintColor:kLoginNavgationbarBackgrounColor];
    [navBar setBarTintColor:kLoginNavgationbarBackgrounColor];
    //    navBar.barTintColor = [UIColor colorWithHexString:@"f9f9f9"];
    //    navBar.backgroundColor = [UIColor yellowColor];
    
    //    navBar.alpha = 0.3000;
    /**
     *  透明度
     */
    [navBar setTranslucent:NO];
    /**
     *  tintColor: 导航栏的按钮(如返回)颜色
     titleTextAttributes: 标题颜色
     barTintColor: 背景颜色
     translucent: 是否透明
     */
    
    
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    /**
     *  我们可以使用UIApplication的statusBarStyle方法来设置状态栏，不过，首先需要停止使用View controller-based status bar appearance。在project target的Info tab中，插入一个新的key，名字为View controller-based status bar appearance，并将其值设置为NO。
     */
    //        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    /**
     *  上面的方法在ios9中会有警告,建议使用这个方法,使用这个方法要在project target的Info tab中，插入一个新的key，名字为View controller-based status bar appearance，并将其值设置为YES
     */
    return UIStatusBarStyleDefault;
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
