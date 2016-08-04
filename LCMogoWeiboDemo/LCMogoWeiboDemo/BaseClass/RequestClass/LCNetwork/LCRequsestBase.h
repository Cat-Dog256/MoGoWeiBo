//
//  LCRequsestBase.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/17.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCCacheConst.h"
#import "AFNetworking.h"
//上传block
typedef void (^AFConstructingBlock)(id<AFMultipartFormData> formData);
typedef enum : NSUInteger {
    GET,
    POST,
    PUT,
    DELETE,
    POST_UPLOAD,
} HttpRequestMethod;
@interface LCRequsestBase : NSObject
/**
 *  发起请求的方式
 */
@property (nonatomic , assign) HttpRequestMethod httpRequestMethod;

/**
 *  请求的网址
 */
@property (nonatomic , copy) NSString *UrlString;

/**
 *  请求的参数
 */
@property (nonatomic , strong) NSMutableDictionary *params;
/**
 *  请求头 这部分的代码没写
 */
@property (nonatomic, strong) NSDictionary *httpHeaders;
/**
 *  请求唯一标示
 */
@property (nonatomic, copy) NSString *identifier;
/**
 *  请求二级标识
 */
@property (nonatomic, copy) NSString *secondIden;
/**
 *  缓存策略
 */
@property (nonatomic, assign) LCRequestCachePolicy cachePolicy;

/**
 *  缓存过期时间 defult is 0;
 */
@property (nonatomic) LCCacheExpiredTime cacheExpiredTime;
/**
 *  上传block
 */
@property (nonatomic, copy) AFConstructingBlock constuctingBlock;
/**
 *  拼接网址
 *
 *  @param urlPath [NSString stringWithFormat:@"%@/%@",kBaseUrl,urlPath]
 */
- (void)appendUrl:(NSString *)urlPath;
/**
 *  创建网路请求类
 *
 *  @param request 请求参数
 *
 *  @return 请求类
 */
- (instancetype)initWithRequest:(LCRequsestBase *)request;

/**
 *  扩展属性
 */
@property (nonatomic , strong) NSDictionary *expandProperties;

@end
