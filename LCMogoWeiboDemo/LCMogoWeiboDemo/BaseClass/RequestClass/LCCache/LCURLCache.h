//
//  LCURLCache.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/21.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCCacheConst.h"
#import "LCDBConst.h"

@interface LCURLCache : NSObject
+ (instancetype)sharedCache;

/**
 *  缓存时间
 */
@property (nonatomic) NSTimeInterval defultExpiredTime;
/**
 *  查询是否存在（包括缓存时间判断，缓存是否存在）
 */
- (BOOL)isExistCache:(NSString *)identifier expiredTime:(LCCacheExpiredTime)expiredTime;
/**
 *  是否有缓存
 */
- (BOOL)isExistCache:(NSString *)identifier ;
/**
 *  查询缓存是否有效 也就是是否过期，返回yes 没过期
 */
- (BOOL)isCacheEffectiveWithIdentifier:(NSString *)identifier expiredTime:(LCCacheExpiredTime)expiredTime;
/**
 *  添加缓存
 *
 *  @param contentDic  缓存的内容
 *  @param cachePolicy 缓存策略
 *  @param userInfo    用户信息
 *  @param identifier  唯一标识
 *
 *  @return 是否成功
 */
- (BOOL)addCacheWithContent:(NSDictionary *)contentDict
                cachePolicy:(LCRequestCachePolicy)cachePolicy
                   userInfo:(NSDictionary *)userInfo
                 identifier:(NSString *)identifier;
/**
 *  取缓存
 */
- (NSDictionary *)getBackData:(NSString *)identifier;
/**
 *  更新缓存
 *
 *  @param indentifier 唯一标识
 */
- (BOOL)updateDataWithIdentifier:(NSString *)identifier content:(NSDictionary *)contentDict;
/**
 *  清除缓存
 */
- (BOOL)cleanCache:(NSString *)identifier;
@end
