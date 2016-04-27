//
//  LCConfigHelper.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/17.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCConfigHelper.h"
static int MaxConcurrentOperationCount = 10;
static int HttpRequestTimeout = 5;

@implementation LCConfigHelper
+ (int)getHttpRequestTimeout{
    return HttpRequestTimeout;
}
+(int)getMaxConcurrentOperationCount{
    return MaxConcurrentOperationCount;
}

@end
