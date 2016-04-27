//
//  LCUserInfoReformer.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCUserInfoReformer.h"

@implementation LCUserInfoReformer
- (LCRequsestBase *)prepareRequest{
    self.myRequest.UrlString = @"https://api.weibo.com/2/users/show.json";
    self.myRequest.httpRequestMethod = GET;
    self.myRequest.identifier = @"userinfo";
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    
    //参数是否为空的判断
    BOOL b = [self judgeParamsState:self.uid paramName:@"uid"];
    if(!b){
        return nil;
    }
    
    [tempDic setObject:self.uid forKey:@"uid"];
    [tempDic setObject:self.access_token forKey:@"access_token"];
//    NSString *encryptJson = [self useAESEncrypted:tempDic];
//    if(self.isOpenED){
//        [self.myRequest.params setObject:encryptJson forKey:@"uid"];
//    }else{
//        [self.myRequest.params setObject:tempDic forKey:@"uid"];
//    }
    [self.myRequest.params addEntriesFromDictionary:tempDic];
    LCLogWarn(@"%@",self.myRequest.params);
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
-(void)requestSuccess:(LCResponse *)response{
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
- (void)requestFailure:(LCResponse *)response{
    [super requestFailure:response];
}
#pragma mark - 从父类继承的方法，主要是重组数据用
- (id)recombinantDataWith:(id)data
{
    [super recombinantDataWith:data];
    //外层model
    self.userInfoModel = [LCUserInfoModel mj_objectWithKeyValues:data];
    return data;
}

@end
