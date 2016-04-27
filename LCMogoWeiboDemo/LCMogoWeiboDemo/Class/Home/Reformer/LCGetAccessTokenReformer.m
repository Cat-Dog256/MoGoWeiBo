//
//  LCGetAccessTokenReformer.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/19.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCGetAccessTokenReformer.h"

@implementation LCGetAccessTokenReformer
#pragma mark - 请求之前准备request
- (LCRequsestBase *)prepareRequest
{
    
    self.myRequest.UrlString = @"https://api.weibo.com/oauth2/access_token";
    
    self.myRequest.httpRequestMethod = POST;
    
    [self.myRequest.params addEntriesFromDictionary:self.bodyDict];
    LCLogVerbose(@"%@",self.myRequest.params);
    self.myRequest.identifier = @"access_token";
    [super prepareRequest];
    
    return self.myRequest;
}
#pragma mark - 请求方法
- (void)requestDataWithHUDView:(UIView *)view
{
    //获得准备好的request
    LCRequsestBase *req = [self prepareRequest];
    //调用父类方法开始请求
    [self startWithRequest:req withView:view];
}

#pragma mark - 请求成功回调方法
- (void)requestSuccess:(LCResponse *)response
{
#ifdef ENVIRON_DEVELOP
    //封装假数据参数
    self.fakeDataParams.identifier = self.myRequest.identifier;
    //取得假数据，并将response.responseDic替换为假数据
    response.responseObject = [self replaceDataFromFakeDataWithIdentifier:self.fakeDataParams];
#endif
    //重组数据
    [self recombinantDataWith:response.responseObject];
    [super requestSuccess:response];
}
#pragma mark - 请求失败回调方法
- (void)requestFailure:(LCResponse *)response
{
    [super requestFailure:response];
}
#pragma mark - 从父类继承的方法，主要是重组数据用
- (id)recombinantDataWith:(NSDictionary *)data
{
    [super recombinantDataWith:data];
    //外层model
    self.accessTokenmodel = [LCAccessTokenModel mj_objectWithKeyValues:data];
    return data;
}

@end
