//
//  LCPostMessageReformer.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/30.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCPostMessageReformer.h"

@implementation LCPostMessageReformer
- (LCRequsestBase *)prepareRequest{
    if (self.imagesArray.count != 0) {
        self.myRequest.UrlString = @"https://upload.api.weibo.com/2/statuses/upload.json";
        self.myRequest.httpRequestMethod = POST_UPLOAD;
        self.myRequest.identifier = @"statuses/upload";
        __weak __typeof(self) weakSelf = self;
        self.myRequest.constuctingBlock = ^(id<AFMultipartFormData>  _Nonnull formData){
            /*
             Data: 需要上传的数据
             name: 服务器参数的名称
             fileName: 文件名称
             mimeType: 文件的类型
             */
        for (int i = 0; i < self.imagesArray.count; i++) {
                UIImage *image = weakSelf.imagesArray[i];
                NSData *data = UIImagePNGRepresentation(image);
                [formData appendPartWithFileData:data name:@"pic" fileName:[NSString stringWithFormat:@"%dimage.png",i] mimeType:@"image/png"];
            }
        };
        
    }else{
        self.myRequest.UrlString = @"https://api.weibo.com/2/statuses/update.json";
        self.myRequest.httpRequestMethod = POST;
        self.myRequest.identifier = @"statuses/update";
       
    }

    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
   BOOL statusB =  [self judgeParamsState:self.status paramName:@"status"];
    if (!statusB) {
        return nil;
    }
    [tempDic setObject:self.status forKey:@"status"];
    [tempDic setObject:self.access_token forKey:@"access_token"];
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
    req.cacheExpiredTime = LCCacheExpiredTimeDefult;
    req.cachePolicy = LCRequestCacheNone;
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

@end
