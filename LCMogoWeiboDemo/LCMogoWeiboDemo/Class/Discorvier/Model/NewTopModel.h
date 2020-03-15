//
//  NewTopModel.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 2020/3/14.
//  Copyright © 2020 李策. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "LCBaseModel.h"
#import "NewResponseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface NewTopModel : LCBaseModel
@property (nonatomic, strong) NewResponseModel *result;
@property (nonatomic, strong) NSString * error_code;
@property (nonatomic, strong) NSString * reason;
@end

NS_ASSUME_NONNULL_END
