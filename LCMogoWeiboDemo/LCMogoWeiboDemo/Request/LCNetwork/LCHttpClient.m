//
//  LCHttpClient.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/17.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCHttpClient.h"
#import "AFNetworking.h"
#import "LCConfigHelper.h"
@interface LCHttpClient ()
{
    AFHTTPSessionManager *_HttpSessionManager;
}
@end

@implementation LCHttpClient
- (instancetype)init{
    if (self = [super init]) {
        _HttpSessionManager = [AFHTTPSessionManager manager];
        _HttpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json",@"application/json",@"text/plain", nil];
    }
    return self;
}

- (void)requestWithRequester:(LCRequsestBase *)requester success:(Success)requestSuccess failure:(Failure)requestFailure{
    if (!requester) return;
    self.requsetSuccess = requestSuccess;
    self.requsetFailure = requestFailure;
    [self prepareAndStart:requester];
}
- (void)cancel{
    [_HttpSessionManager.operationQueue cancelAllOperations];
}
- (void)prepareAndStart:(LCRequsestBase *)request{
    if (!request || !request.UrlString) {
        ReqLog(@"没有请求类型 , 无效的URL");
        return;
    }
    NSString *url = [request.UrlString copy];
    NSDictionary *params = request.params;
    HttpRequestMethod requestMethod = request.httpRequestMethod;
    [self requestWithUrl:url requestMethod:requestMethod params:params expandProperties:nil];
}

- (void)requestWithUrl:(NSString *)url requestMethod:(HttpRequestMethod)requestMethod params:(NSDictionary *)params expandProperties:(NSDictionary *)expandDict{
    __weak __typeof(self)weakSelf = self;
    if (requestMethod == POST) {
        [_HttpSessionManager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            LCResponse *response = [weakSelf successWith:task responseObject:responseObject];
            weakSelf.requsetSuccess(response);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            LCResponse *response = [weakSelf failureWith:task error:error];
            weakSelf.requsetFailure(response);
        }];
    }else if (requestMethod == GET){
        [_HttpSessionManager GET:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            LCResponse *response = [weakSelf successWith:task responseObject:responseObject];
            if (response) {
                weakSelf.requsetSuccess(response);
            }else{
                ReqLog(@"response = nil");
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            LCResponse *response = [weakSelf failureWith:task error:error];
            if (response) {
                weakSelf.requsetFailure(response);
            }else{
                ReqLog(@"response = nil");
            }
        }];

    }
}

- (LCResponse *)successWith:(NSURLSessionDataTask *)task responseObject:(id)responseObject{
    LCResponse *response = [[LCResponse alloc]init];
    response.responseObject = responseObject;
    response.responseString = @"不知道怎么写!!!";
    response.task = task;
    return response;
}
- (LCResponse *)failureWith:(NSURLSessionDataTask *)task error:(NSError *)error{
    LCResponse *response = [[LCResponse alloc]init];
    response.error = error;
    response.task = task;
    return response;
}
@end
