//
//  LCPostMessageReformer.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/30.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCBaseReformer.h"

@interface LCPostMessageReformer : LCBaseReformer
@property (nonatomic , strong) NSString *access_token;
@property (nonatomic , strong) NSString *status;
/**
 *  图片的数组,公开接口只支持上传一张图片
 */
@property (nonatomic , strong) NSArray *imagesArray;
/**
 *  请求方法
 *
 *  @param view loading显示的view
 */
- (void)requestDataWithHUDView:(UIView *)view;

@end
