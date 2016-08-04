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
#import "UIKit+AFNetworking.h"
@interface LCHttpClient ()
{
    AFHTTPSessionManager *_HttpSessionManager;
}
@end

@implementation LCHttpClient
- (instancetype)init{
    if (self = [super init]) {
      
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
    [self requestWithUrl:url requestMethod:requestMethod params:params upload:request.constuctingBlock expandProperties:nil];
}

- (void)requestWithUrl:(NSString *)url requestMethod:(HttpRequestMethod)requestMethod params:(NSDictionary *)params  upload:(AFConstructingBlock)constructingBlock expandProperties:(NSDictionary *)expandDict {
    __weak __typeof(self)weakSelf = self;
    if (!_HttpSessionManager) {
        _HttpSessionManager = [AFHTTPSessionManager manager];
        _HttpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json",@"application/json",@"text/plain", nil];
        
        /**
         *  JSON转换AFN内置
         */
//        _HttpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
//        _HttpSessionManager.requestSerializer=[AFJSONRequestSerializer serializer];
        /**
         *  最大并发数
         */
        _HttpSessionManager.operationQueue.maxConcurrentOperationCount = [LCConfigHelper getMaxConcurrentOperationCount];
        /**
         *  超时时间
         */
        _HttpSessionManager.requestSerializer.timeoutInterval = [LCConfigHelper getHttpRequestTimeout];
    }
 
    
    if (requestMethod == POST) {
        [_HttpSessionManager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            LCResponse *response = [weakSelf successWith:task responseObject:responseObject];
            if (weakSelf.requsetSuccess) {
                 weakSelf.requsetSuccess(response);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            LCResponse *response = [weakSelf failureWith:task error:error];
            if (weakSelf.requsetFailure) {
                weakSelf.requsetFailure(response);
            }
        }];
    }else if (requestMethod == GET){
        [_HttpSessionManager GET:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            LCResponse *response = [weakSelf successWith:task responseObject:responseObject];
            if (weakSelf.requsetSuccess) {
                weakSelf.requsetSuccess(response);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            LCResponse *response = [weakSelf failureWith:task error:error];
            if (weakSelf.requsetFailure) {
                weakSelf.requsetFailure(response);
            }
        }];

    }else if (requestMethod == POST_UPLOAD){
//    [HttpSessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
        /**
         *  文件上传
         *
         *  @param formData data
         *
         *  @return 无
         */
        [_HttpSessionManager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            constructingBlock(formData);
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            ReqLog(@"%f",uploadProgress.fractionCompleted);
           
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            LCResponse *response = [weakSelf successWith:task responseObject:responseObject];
            weakSelf.requsetSuccess(response);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            LCResponse *response = [weakSelf failureWith:task error:error];
            weakSelf.requsetFailure(response);
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
