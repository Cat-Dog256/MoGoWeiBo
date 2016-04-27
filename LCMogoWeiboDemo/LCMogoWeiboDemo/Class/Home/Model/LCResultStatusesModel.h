//
//  LCResultStatusesModel.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCBaseModel.h"
#import "LCStatusesModel.h"
@interface LCResultStatusesModel : LCBaseModel
@property (nonatomic , strong) NSArray *statuses;
@property (nonatomic , strong) NSNumber *total_number;
@end
