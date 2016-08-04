//
//  LCAppTabBarController.m
//  sunshineTeacher
//
//  Created by MoGo on 16/6/3.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCAppTabBarController.h"
#import "LCNavgationController.h"

@implementation LCAppTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /**
     *  第一步:设置title字体大小,颜色
     */
    self.titleFont = kMidTextFont;
    self.titleNormallColor = kMaxBlackColor;
    self.titleSelectedColor = kYGTBaseColor;
    /**
     *  第二步:添加VC
     */
    [self setuoAllViewControllers];
    
    
    // Do any additional setup after loading the view.
}
- (void)setuoAllViewControllers{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"APPTabBarItemsConfiguration" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary *dict in array) {
        LCNavgationController *VC = [[LCNavgationController alloc]initWithRootViewController:[[NSClassFromString(dict[@"conttrollerName"]) alloc]init]];
//#pragma mark --设置导航栏的背景颜色
//        [VC.navigationBar setTintColor:kYGTBaseColor];
//        [VC.navigationBar setBarTintColor:kYGTBaseColor];
//#warning why initialize 为什么要主动调用
        [LCNavgationController initialize];
        [self addChildVC:VC normalImage:[UIImage imageNamed:dict[@"normalImageName"]] selectImage:[UIImage imageNamed:dict[@"selectedImageName"]] tabBarTitle:dict[@"tabBarTitle"]];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
