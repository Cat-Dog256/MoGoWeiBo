//
//  LCToolBar.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/27.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCStatusesModel;
@interface LCToolBar : UIView
@property (nonatomic , strong) LCStatusesModel *statusesModel;
+ (instancetype)toolBar;
@end
