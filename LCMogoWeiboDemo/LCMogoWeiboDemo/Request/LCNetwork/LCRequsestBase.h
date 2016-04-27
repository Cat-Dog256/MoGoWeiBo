//
//  LCRequsestBase.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/17.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCCacheConst.h"

typedef enum : NSUInteger {
    GET,
    POST,
    PUT,
    DELETE,
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
 *  请求头
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

//@property (nonatomic, copy) AFConstructingBlock constuctingBlock;

- (instancetype)initWithRequest:(LCRequsestBase *)request;

/**
 *  扩展属性
 */
@property (nonatomic , strong) NSDictionary *expandProperties;

@end
