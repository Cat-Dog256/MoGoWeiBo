//
//  LCButton.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/28.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCButton;
typedef void (^buttonAction)(LCButton *button);
@interface LCButton : UIButton
- (instancetype)initWithFrame:(CGRect)frame titleLabelFont:(CGFloat)font text:(NSString *)text buttonAction:(buttonAction)btnAction;

@end
