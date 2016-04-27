//
//  LCUserInfoReformer.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCBaseReformer.h"
#import "LCUserInfoModel.h"
@interface LCUserInfoReformer : LCBaseReformer
/**
 * 用户信息
 */
@property (nonatomic , strong) LCUserInfoModel *userInfoModel;
@property (nonatomic , strong) NSString *access_token;
/**
 *  用户ID
 */
@property (nonatomic , strong) NSNumber *uid;
/**
 *  用户名字
 */
@property (nonatomic , strong) NSString *screen_name;
/**
 *  请求方法
 *
 *  @param view loading显示的view
 */
- (void)requestDataWithHUDView:(UIView *)view;

@end
