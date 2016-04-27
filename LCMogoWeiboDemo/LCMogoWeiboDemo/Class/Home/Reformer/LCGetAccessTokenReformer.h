//
//  LCGetAccessTokenReformer.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/19.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCBaseReformer.h"
#import "LCAccessTokenModel.h"
@interface LCGetAccessTokenReformer : LCBaseReformer
@property (nonatomic , strong) LCAccessTokenModel *accessTokenmodel;
@property (nonatomic , strong) NSDictionary *bodyDict;
/**
 *  请求方法
 *
 *  @param view loading显示的view
 */
- (void)requestDataWithHUDView:(UIView *)view;

@end
