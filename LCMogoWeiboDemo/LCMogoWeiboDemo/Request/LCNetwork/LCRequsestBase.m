//
//  LCRequsestBase.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/17.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCRequsestBase.h"

@implementation LCRequsestBase
- (instancetype)initWithRequest:(LCRequsestBase *)request
{
    if(self = [super init]){
        //请求参数
        self.params = request.params;
        //请求类型
        self.httpRequestMethod = request.httpRequestMethod;
        //请求URL
        self.UrlString = request.UrlString;
        //请求头
        self.httpHeaders = request.httpHeaders;
        //请求唯一标示
        self.identifier = request.identifier;
        //缓存策略
        self.cachePolicy = request.cachePolicy;
        //缓存过期时间
        self.cacheExpiredTime = request.cacheExpiredTime;

    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.cacheExpiredTime = 0;
    }
    return self;
}

#pragma mark - getter
- (NSMutableDictionary *)params
{
    if(_params == nil){
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}

@end
