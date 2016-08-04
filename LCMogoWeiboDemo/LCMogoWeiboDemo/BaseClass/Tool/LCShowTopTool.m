//
//  LCShowTopTool.m
//  sunshineTeacher
//
//  Created by MoGo on 16/6/7.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCShowTopTool.h"

@implementation LCShowTopTool
-(instancetype)init
{
    if (self = [super init]) {
        
        self.isCompleted = YES;
    }
    return self;
}

-(void)showTopFromView:(UIView *)currentView withMessage:(NSString *)message{
    
    //获取界面上最后一个window
    UIWindow * lastWindow = [UIApplication sharedApplication].windows.lastObject;
    
    if (self.isCompleted) {
        
        self.isCompleted = !self.isCompleted;
        
        UILabel * showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -40, SCREEN_WIDTH, 40)];
        showLabel.text = message;
        showLabel.font = [UIFont systemFontOfSize:15];
        showLabel.textColor = [UIColor whiteColor];
        showLabel.textAlignment = NSTextAlignmentCenter;
        showLabel.backgroundColor = [UIColor colorWithHexString:@"#9e9e9e" alpha:0.8];
        [lastWindow addSubview:showLabel];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            showLabel.transform = CGAffineTransformMakeTranslation(0, showLabel.height);
            
            
        } completion:^(BOOL finished) {
            
            
            [NSThread sleepForTimeInterval:0.6];
            
            [UIView animateWithDuration:0.3 animations:^{
                
                showLabel.transform = CGAffineTransformMakeTranslation(0, -showLabel.height);
                
            } completion:^(BOOL finished) {
                
                [self clearWindow];
                self.isCompleted = YES;
                
            }];
            
        }];
    }
    
}

-(void)clearWindow{
    
    UIWindow *lastWindow = [UIApplication sharedApplication].windows.lastObject;
    
    for (UIView * view in lastWindow.subviews) {
        
        if ([view isKindOfClass:[UILabel class]]){
            
            [view removeFromSuperview];
        }
    }
}

@end
