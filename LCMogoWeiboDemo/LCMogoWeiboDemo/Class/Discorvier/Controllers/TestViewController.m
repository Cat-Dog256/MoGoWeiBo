//
//  TestViewController.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 2020/3/12.
//  Copyright © 2020 李策. All rights reserved.
//

#import "TestViewController.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(pressButton) forControlEvents:UIControlEventTouchUpInside];
    LCButton *button2 = [[LCButton alloc]initWithFrame:CGRectMake(100, 220, 100, 100)];
    button2.backgroundColor = [UIColor redColor];
    [self.view addSubview:button2];
    [button2 addAction:^(LCButton *button) {
        self.popBlock(LCRandomColor);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    // Do any additional setup after loading the view.
}
- (void)pressButton{
    if (self.delegate || [self.delegate performSelector:@selector(popVc:)]) {
        [self.delegate popVc:LCRandomColor];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pressButton2{
    if (self.popBlock) {
        self.popBlock(LCRandomColor);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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
