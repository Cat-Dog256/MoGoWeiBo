//
//  LCAccessTokenModel.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/17.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCBaseModel.h"

@interface LCAccessTokenModel : LCBaseModel
@property (nonatomic , strong) NSNumber *uid;
@property (nonatomic , strong) NSNumber *expires_in;
@property (nonatomic , strong) NSString *access_token;
@property (nonatomic , strong) NSNumber *remind_in;
@end
