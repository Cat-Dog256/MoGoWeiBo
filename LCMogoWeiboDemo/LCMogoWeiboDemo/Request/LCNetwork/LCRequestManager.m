//
//  LCRequestManager.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/19.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCRequestManager.h"
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"
#import "UIColor+Extension.h"
#import "LCException.h"
@interface LCRequestManager ()<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@end

@implementation LCRequestManager


- (void)startRequest:(LCRequsestBase *)request withView:(UIView *)view{
    [HUD hide:YES];
    static BOOL isFirst = YES;
    if (![[LCReachabilityManager sharedReachabilityManager] isReachable] && !isFirst) {
        ReqLog(@"没有网而且不是第一次执行");
#warning todo  注意
    }
    isFirst = NO;
    
    if (view != nil) {
        [self showHudWithView:view];
    }
    //如果没有request直接返回
    if (!request) {
        
        LCResponse *requestErrorResponse = [[LCResponse alloc]init];
        
        NSError *errorNoRequest = [NSError errorWithDomain:@"无请求" code:100001 userInfo:nil];
        requestErrorResponse.error = errorNoRequest;
        
        [self generalCallBack:requestErrorResponse];
        
        ReqLog(@"无请求");
        return;
    }
    __weak __typeof(self)weakSelf = self;
    self.httpClient = [[LCHttpClient alloc]init];
    
    [self.httpClient requestWithRequester:request success:^(LCResponse *response) {
        [HUD hide:YES];
        [weakSelf generalCallBack:response];
        
    } failure:^(LCResponse *response) {
        [HUD hide:YES];
        [weakSelf generalCallBack:response];
    }];

}
- (void)cancelAllOperations{
    [self.httpClient cancel];
}
- (void)generalCallBack:(LCResponse *)response
{
    LCResponse *bkResponse = [[LCResponse alloc]init];
    bkResponse = response;
    if (response.error) {
        if(self.delegate || [self.delegate respondsToSelector:@selector(requestFailure:)]){
            [self.delegate requestFailure:bkResponse];
        }
    }else{
        if(self.delegate || [self.delegate respondsToSelector:@selector(requestSuccess:)]){
            [self.delegate requestSuccess:bkResponse];
        }
    }
}

- (void)showHudWithView:(UIView *)view{
    HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    [HUD setColor:[UIColor clearColor]];
    
    UIImage *image = [UIImage sd_animatedGIFNamed:@"loading"];
    
    HUD.customView = [[UIImageView alloc] initWithImage:image];
//    HUD.labelText = @"加载中。。。";
    
    HUD.mode = MBProgressHUDModeCustomView;
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    //    HUD.delegate = self;
    
    // Show the HUD while the provided method executes in a new thread
    [view bringSubviewToFront:HUD];
    
    [HUD show:YES];
}


- (void)reachablitiyManager:(LCReachabilityManager *)manager status:(AFNetworkReachabilityStatus)status{
    switch (status) {
        case AFNetworkReachabilityStatusReachableViaWiFi:
        case AFNetworkReachabilityStatusReachableViaWWAN:
            [LCException exception].online = YES;
            [[LCException exception] processNetExceptionWithNetState:LCExceptionNetStateConnected];
            ReqLog(@"有网了");
            break;
        case AFNetworkReachabilityStatusNotReachable:
        default:
            [LCException exception].online = NO;
            [HUD hide:YES];
            [[LCException exception] processNetExceptionWithNetState:LCExceptionNetStateBroken];
            ReqLog(@"没有网了");
            break;
    }

}

- (instancetype)init
{
    if(self = [super init]){
        
        LCReachabilityManager *reachMgr = [LCReachabilityManager sharedReachabilityManager];
        
        reachMgr.delegate = self;
#warning kBaseUrl 主机地址
        [reachMgr httpManagerReachabitiyWithBaseURL:kBaseUrl];
        
    }
    return self;
}

#pragma  mark - 设置单例
static id _instace;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
        
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instace;
}
@end
