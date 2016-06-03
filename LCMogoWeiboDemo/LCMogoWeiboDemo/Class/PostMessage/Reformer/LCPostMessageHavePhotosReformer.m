//
//  LCPostMessageHavePhotosReformer.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/30.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCPostMessageHavePhotosReformer.h"
#import "MJExtension.h"
@implementation LCPostMessageHavePhotosReformer
- (LCRequsestBase *)prepareRequest{
    self.myRequest.UrlString = @"http://121.199.21.212/clubx-web/api/app/ios/products/addOnce";
    self.myRequest.httpRequestMethod = POST_UPLOAD;
    self.myRequest.identifier = @"statuses/upload";
    self.myRequest.constuctingBlock = ^(id<AFMultipartFormData>  _Nonnull formData){
        /*
         Data: 需要上传的数据
         name: 服务器参数的名称
         fileName: 文件名称
         mimeType: 文件的类型
         */
        UIImage *image =[UIImage imageNamed:@"test"];
        NSData *data = UIImagePNGRepresentation(image);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"abc.png" mimeType:@"image/png"];
        
        
        
        
        for (int i = 0; i < 10; i++) {
            LCLogError();
            UIImage *image =[UIImage imageNamed:@"test"];
            NSData *data = UIImagePNGRepresentation(image);
            // 上传的参数名
//            NSString * Name = [NSString stringWithFormat:@"%d", i+1];
            // 上传filename
            NSString * fileName = [NSString stringWithFormat:@"%dimage.png", i];
            if (i == 0) {
                fileName = @"thumbFile";
            }
            [formData appendPartWithFileData:data name:@"pic" fileName:fileName mimeType:@"image/png"];
        }
        /*
         NSURL *url = [NSURL fileURLWithPath:@"/Users/apple/Desktop/CertificateSigningRequest.certSigningRequest"];
         // 任意的二进制数据MIMEType application/octet-stream
         // [formData appendPartWithFileURL:url name:@"file" fileName:@"abc.cer" mimeType:@"application/octet-stream" error:nil];
         [formData appendPartWithFileURL:url name:@"file" error:nil];
         */
    
    };
    
    
    
        NSString *token = @"e90d6870ea29c1832a2bfde86cecb241";
        NSNumber *userId = @43;
    
        // 最大字典
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:token forKey:@"token"];
        [dic setObject:userId forKey:@"userId"];
    
        // json字典
        NSMutableDictionary *goodsJsonDic = [NSMutableDictionary dictionary];
        [goodsJsonDic setObject:@1 forKey:@"cate"]; // 1普通课程 2运动旅行
        [goodsJsonDic setObject:@"温州一日游" forKey:@"name"]; // 标题
        //  商品类型字典
        NSMutableDictionary *goodTypesDic = [NSMutableDictionary dictionary];
        [goodTypesDic setObject:@1 forKey:@"id"]; //id类型编号 潜水、滑雪、跳伞、越野、冲浪
        [goodsJsonDic setObject:goodTypesDic forKey:@"goodsType"];
    
        // location字典
        NSMutableDictionary *locationDic = [NSMutableDictionary dictionary];
        [locationDic setObject:@"巴厘岛" forKey:@"lname"];
        [locationDic setObject:@56 forKey:@"id"];
        [goodsJsonDic setObject:locationDic forKey:@"location"];
    
        [goodsJsonDic setObject:@2 forKey:@"locationType"];  //0不限 1国内 2国外
        [goodsJsonDic setObject:@"9999" forKey:@"price"];
        [goodsJsonDic setObject:@1 forKey:@"discount"];
        [goodsJsonDic setObject:@"2016-01-01" forKey:@"startTime"];
        [goodsJsonDic setObject:@"2016-12-12" forKey:@"endtTime"];
        [goodsJsonDic setObject:@"体验温州洪水游泳" forKey:@"intro"]; //简介
        [goodsJsonDic setObject:@"包含" forKey:@"includedFees"];
        [goodsJsonDic setObject:@"不包含" forKey:@"noIncludedFees"];
        [goodsJsonDic setObject:@"详情" forKey:@"details"];
        [goodsJsonDic setObject:@"退款说明" forKey:@"refundIntro"];
        [goodsJsonDic setObject:@"其他提示" forKey:@"otherTips"];
        [goodsJsonDic setObject:@"标签" forKey:@"tags"];
    
        NSMutableArray *schedulesArray = [NSMutableArray array];
        NSMutableDictionary *schedulesDic = [NSMutableDictionary dictionary];
        [schedulesDic setObject:@"Day2" forKey:@"theme"];
        [schedulesDic setObject:@"下水" forKey:@"content"];
        [schedulesDic setObject:@0 forKey:@"calendarType"];
        [schedulesDic setObject:@0 forKey:@"scheduleId"];
        [schedulesArray addObject:schedulesDic];
        [goodsJsonDic setObject:schedulesArray forKey:@"schedules"];
    
    
        NSMutableArray *skusArray = [NSMutableArray array];
        NSMutableDictionary *skusDic = [NSMutableDictionary dictionary];
        [skusDic setObject:@"套餐" forKey:@"attr"];
        [skusDic setObject:@"名字" forKey:@"attrValue"];
        [skusDic setObject:@"描述" forKey:@"skuName"];
        [skusDic setObject:@0 forKey:@"typeId"];
        [skusDic setObject:@999 forKey:@"skuNums"];
        [skusDic setObject:@"999" forKey:@"skuPrice"];
        [skusArray addObject:skusDic];
        [goodsJsonDic setObject:skusArray forKey:@"skus"];
        NSString *goodsJson = [goodsJsonDic mj_JSONString];
        [dic setObject:goodsJson forKey:@"goodsJSON"];

    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    
    
    [tempDic setObject:self.status forKey:@"status"];
    [tempDic setObject:self.access_token forKey:@"access_token"];
    [self.myRequest.params addEntriesFromDictionary:dic];
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
- (void)requestFailure:(LCResponse *)response{
    [super requestFailure:response];
    LCLogError(@"%@",response.error);
}
@end
