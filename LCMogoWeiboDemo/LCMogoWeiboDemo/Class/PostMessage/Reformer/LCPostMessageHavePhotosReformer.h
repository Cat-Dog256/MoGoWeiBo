//
//  LCPostMessageHavePhotosReformer.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/30.
//  Copyright © 2016年 李策. All rights reserved.
// 用club接口测试多张图片的上传

#import "LCBaseReformer.h"

@interface LCPostMessageHavePhotosReformer : LCBaseReformer
@property (nonatomic , strong) NSString *access_token;
@property (nonatomic , strong) NSString *status;

/**
 *  请求方法
 *
 *  @param view loading显示的view
 */
- (void)requestDataWithHUDView:(UIView *)view;
@end
