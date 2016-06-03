//
//  LCMoGoWeiBoTabBarController.m
//  MoGoWeiBo
//
//  Created by 李策 on 16/4/7.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCMoGoWeiBoTabBarController.h"
#import "LCTabBar.h"
#import "LCHomeTableViewController.h"
#import "LCMessageTableViewController.h"
#import "LCPostMessageViewController.h"
#import "LCDiscorverTableViewController.h"
#import "LCProfileTableViewController.h"

#import "LCNavgationController.h"
@interface LCMoGoWeiBoTabBarController ()<LCTabBarDelegate>

@end

@implementation LCMoGoWeiBoTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     如果tabBar是类似微博这种比较特殊的形式,就需要用自定义的tabBar来替换掉系统的TabBar,如果是正常的直接注释掉这句
     */
    LCTabBar *tabBar = [[LCTabBar alloc]init];
    tabBar.tabBar_delegate = self;
#pragma mark**使用KVC改掉系统的TabBar**
    [self setValue:tabBar forKeyPath:@"tabBar"];
    

    /**
     *  第一步:设置title字体大小,颜色
     */
    self.titleFont = [UIFont systemFontOfSize:12.5];
    self.titleNormallColor = [UIColor grayColor];
    self.titleSelectedColor = [UIColor orangeColor];
    /**
     *  第二步:添加VC
     */
    [self setuoAllViewControllers];
        // Do any additional setup after loading the view.
}
- (void)setuoAllViewControllers{
//    /**
//     首页
//     */
//    LCHomeTableViewController *homeVC = [[LCHomeTableViewController alloc]init];
//    LCNavgationController *homeNav = [[LCNavgationController alloc]initWithRootViewController:homeVC];
//    [self addChildVC:homeNav normalImage:[UIImage imageNamed:@"tabbar_home"] selectImage:[UIImage imageNamed:@"tabbar_home_selected"] tabBarTitle:@"首页"];
//    /**
//     消息
//     */
//    LCMessageTableViewController *messageVC = [[LCMessageTableViewController alloc]init];
//    LCNavgationController *messageNav = [[LCNavgationController alloc]initWithRootViewController:messageVC];
//    [self addChildVC:messageNav normalImage:[UIImage imageNamed:@"tabbar_message_center"] selectImage:[UIImage imageNamed:@"tabbar_message_center_selected"] tabBarTitle:@"消息"];
//    /**
//     发现
//     */
//    LCDiscorverTableViewController *discorverVC = [[LCDiscorverTableViewController alloc]init];
//    LCNavgationController *discorverNav = [[LCNavgationController alloc]initWithRootViewController:discorverVC];
//    [self addChildVC:discorverNav normalImage:[UIImage imageNamed:@"tabbar_discover"] selectImage:[UIImage imageNamed:@"tabbar_discover_selected"] tabBarTitle:@"发现"];
//    /**
//     我的
//     */
//    LCProfileTableViewController *profileVC = [[LCProfileTableViewController alloc]init];
//    LCNavgationController *profileNav = [[LCNavgationController alloc]initWithRootViewController:profileVC];
//    [self addChildVC:profileNav normalImage:[UIImage imageNamed:@"tabbar_profile"] selectImage:[UIImage imageNamed:@"tabbar_profile_selected"] tabBarTitle:@"我的"];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"APPTabBarItemsConfiguration" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary *dict in array) {
        LCNavgationController *VC = [[LCNavgationController alloc]initWithRootViewController:[[NSClassFromString(dict[@"conttrollerName"]) alloc]init]];
        [self addChildVC:VC normalImage:[UIImage imageNamed:dict[@"normalImageName"]] selectImage:[UIImage imageNamed:dict[@"selectedImageName"]] tabBarTitle:dict[@"tabBarTitle"]];
 
    }
}
/**
 *  中间的加号按钮的点击事件
 */
- (void)tabBarDidClickPlusButton:(LCTabBar *)tabBar{
    
    LCPostMessageViewController *sendMessageVC = [[LCPostMessageViewController alloc]init];
    
    LCNavgationController *nav = [[LCNavgationController alloc]initWithRootViewController:sendMessageVC];
    [self presentViewController:nav animated:YES completion:nil];
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
