//
//  LCBaseViewController.m
//  MoGoWeiBo
//
//  Created by 李策 on 16/4/7.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCBaseViewController.h"
#import "MBProgressHUD.h"
#import "UIBarButtonItem+Extension.h"

@interface LCBaseViewController ()

@end

@implementation LCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  调整导航栏对self.view.size的影响
        但是设置这两个属性之后View导航栏的透明效果就会消失
     */
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netStateChanged:) name:kNotificationNetStateChanged object:nil];
    if (self.navigationController.viewControllers.count > 1) {
         self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backButtonAction:) image:kNavigationbar_back highImage:kNavigationbar_back_highlighted];
    }
    
    self.view.backgroundColor = kBgWhiteColor;

}

- (void)setRightButtonTitle:(NSString *)rightButtonTitle{
    _rightButtonTitle = rightButtonTitle;
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:self.rightButtonTitle style:UIBarButtonItemStyleDone target:self action:@selector(rightButtonAction:)];
    self.navigationItem.rightBarButtonItem.tintColor = kBgWhiteColor;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    

}

- (void)setRightButtonNormalImage:(NSString *)normalImage highImage:(NSString *)highImage{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightButtonAction:) image:normalImage highImage:highImage];
}
- (void)backButtonAction:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightButtonAction:(UIButton *)button{
    
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
/**
 *  数据请求成功的回调
 *
 *  @param reformer reformer
 */
-(void)reformerSuccessWith:(LCBaseReformer *)reformer object:(id)object{

}
/**
 *  数据请求失败的回调
 *
 *  @param reformer reformer
 */
- (void)reformerFailureWith:(LCBaseReformer *)reformer
{
    
}
/**
 *  读取本地缓存的回调
 *
 *  @param reformer reformer
 */
- (void)reformerGetAppCacheWith:(LCBaseReformer *)reformer{
    
}
#pragma mark - public methods
#pragma mark - 用HUD显示错误信息
- (void)showHudMes:(NSString *)mes hiddenDelay:(CGFloat)time
{
    
#pragma mark -- 解决键盘会遮挡提示信息的问题 未测试不知道会出什么问题
    UIWindow *lastWindow = [[UIApplication sharedApplication].windows  lastObject];
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithWindow:lastWindow];
    [lastWindow addSubview:hud];
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
//        hud.labelText = mes;
    hud.animationType =   MBProgressHUDAnimationFade;

    //by guozhenqing  解决文字过多不能折行的问题
    hud.detailsLabelText = mes;
    hud.detailsLabelFont = kBigTextFont;
    
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    hud.alpha = 0.7;
    
    [hud show:YES];
    [hud hide:YES afterDelay:time];
}
#pragma mark - 添加错误界面
- (void)showNetExceptionOn:(UIView *)container
              refreshStyle:(RefreshStyle)style
                showHeader:(BOOL)showHeader
                showFooter:(BOOL)showfooter
                 showFrame:(CGRect)showFrame
              refreshBlock:(void(^)())refreshBlock
{
    [self.showTool showNetBreakIn:container refreshStyle:style showHeader:showHeader showFooter:showfooter showFrame:showFrame refreshBlock:refreshBlock];
}

- (void)showLoadFaildIn:(UIView *)contentV showFrame:(CGRect)rect refreshBlock:(void(^)())refreshBlock{
    [self.showTool showLoadFaildIn:contentV showFrame:rect refreshBlock:refreshBlock];
}
#pragma mark - 移除异常界面
- (void)removeExceptionFrom:(UIView *)container
{
    [self.showTool hiddenLoadFaildFrom:container];
    [self.showTool hiddenNetBreakFrom:container];
}
#pragma mark - event methods

#pragma mark - 收到网络状态改变的通知后调用的方法 此方法类去调用，将添加、刷新、消失的代码写在这个里边
- (void)netStateChanged:(NSNotification *)notification
{
    
    NSDictionary *info = notification.userInfo;
    if ([info[kNetStateKey] isEqualToString:kNetBroken]) {
        [self showHudMes:@"网络断开连接" hiddenDelay:1.25];
        [self netStateChangedMessage:kNetBroken];
    }else if ([info[kNetStateKey] isEqualToString:kNetConnected]){
//        [self showHudMes:@"网络回复连接" hiddenDelay:1.25];
        [self netStateChangedMessage:kNetConnected];
    }
}
- (void)netStateChangedMessage:(NSString *)netState{
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationNetStateChanged object:nil];
}

- (LCShowErrorViewTool *)showTool
{
    if (_showTool == nil) {
        _showTool = [[LCShowErrorViewTool alloc]init];
    }
    return _showTool;
}


@end
