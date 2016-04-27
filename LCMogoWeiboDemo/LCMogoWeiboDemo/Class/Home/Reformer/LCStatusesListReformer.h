//
//  LCStatusesListReformer.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCBaseReformer.h"
#import "LCStatusFrameModel.h"
#import "LCResultStatusesModel.h"
@interface LCStatusesListReformer : LCBaseReformer
@property (nonatomic , strong) LCResultStatusesModel *resultModel;
@property (nonatomic , strong) NSArray *statusesModels;
@property (nonatomic , strong) NSString *access_token;
/**
 *  请求方法
 *
 *  @param view loading显示的view
 */
- (void)requestDataWithHUDView:(UIView *)view;
/**
 *  刷新数据
 *
 *  @param page 页数 下拉刷新为1 上拉加载为page++
 */
- (void)refreshDataWithPage:(NSUInteger)page;
@end
