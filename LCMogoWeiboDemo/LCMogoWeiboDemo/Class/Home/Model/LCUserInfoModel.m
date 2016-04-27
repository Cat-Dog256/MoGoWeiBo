//
//  LCUserInfoModel.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCUserInfoModel.h"

@implementation LCUserInfoModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"uId" : @"id"};
}
- (void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    self.vip = mbtype > 2;
}

@end
