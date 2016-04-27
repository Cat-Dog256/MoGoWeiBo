//
//  LCConfigHelper.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/17.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCConfigHelper : NSObject
/**
 *  @return Http请求超时时间
 */
+(int)getHttpRequestTimeout;
/**
 *  @return Http请求的最大并发数
 */
+(int)getMaxConcurrentOperationCount;
@end
