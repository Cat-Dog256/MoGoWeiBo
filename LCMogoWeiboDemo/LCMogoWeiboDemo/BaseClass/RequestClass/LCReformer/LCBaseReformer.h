//
//  LCBaseReformer.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/19.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCRequestManager.h"
#import "LCFakeDataParams.h"
#import "LCURLCache.h"
@class LCBaseReformer;

@protocol LCBaseReformerDelegate <NSObject>

@required

/**
 *  请求成功回调方法
 *
 *  @param reformer 返回reformer
 *  @param object   返回原始数据
 */
- (void)reformerSuccessWith:(LCBaseReformer *)reformer object:(id)object;
/**
 *  请求失败回调方法
 *
 *  @param reformer 返回reformer
 */
- (void)reformerFailureWith:(LCBaseReformer *)reformer;

@end

@interface LCBaseReformer : NSObject<LCRequestManagerDelegate>

/**
 *  请求成功
 */
@property (nonatomic , assign) BOOL success;
/**
 *  请求状态码
 */
@property (nonatomic , assign) int statusCode;
/**
 *  是否打开加密解密功能
 */
@property (nonatomic,assign) BOOL isOpenED;
/**
 *  处于刷新的数据,调用了refreshDataWithRequest方法是值为YES
 */
@property (nonatomic , assign , readonly) BOOL isRefresh;
/**
 *  代理
 */
@property (nonatomic, weak) id<LCBaseReformerDelegate> delegate;
/**
 *  请求唯一标识
 */
@property (nonatomic, copy) NSString *identfier;
/**
 *  请求二级标识
 */
@property (nonatomic, copy) NSString *secondIden;
/**
 *  request管理者
 */
@property (nonatomic, strong) LCRequestManager *manager;
/**
 *  缓存管理
 */
@property (nonatomic, strong) LCURLCache *appCache;
/**
 *  request
 */
@property (nonatomic, strong) LCRequsestBase *myRequest;

/**
 *  从假数据获取数据传递的参数
 */
@property (nonatomic, strong) LCFakeDataParams *fakeDataParams;
/**
 *  response
 */
@property (nonatomic, strong) LCResponse *response;
/**
 *  设置request 空方法子类重写
 *
 *  @return LCBaseRequest
 */
- (LCRequsestBase *)prepareRequest;

- (instancetype)initWithDelegate:(id)delegate;
/**
 *  参数是否为空的判断
 *  @param param   参数
 *  @paramName 参数描述名
 */
- (BOOL)judgeParamsState:(id)param paramName:(NSString *)paramName;

/**
 *  使用AES加密
 *  @param encryptedDic 要加密的字典
 *  @return 密文
 */
- (NSString *)useAESEncrypted:(NSDictionary *)encryptedDic;
/**
 *  使用RSA加密
 *  @param encryptedDic 要加密的字典
 *  @return 密文
 */
- (NSString *)useRSAEncrypted:(NSDictionary *)encryptedDic;

/**
 *  开始请求
 */
- (void)startWithRequest:(LCRequsestBase *)request withView:(UIView *)view;
/**
 *  刷新时调用请求方法，不判断有无数据，只要刷新就请求数据  不显示hud
 *  @param request 请求request
 */
- (void)refreshDataWithRequest:(LCRequsestBase *)request;

/**
 *  判断是否存在缓存
 *
 *  @param identifier 缓存唯一标识
 *
 *  @return 是否存在缓存
 */
- (BOOL)isExsistOrExpireCache:(NSString *)identifier expiredInteval:(LCCacheExpiredTime)expiredTime;
/**
 *  加载唯一标识的假数据
 *
 *  @param identifier 唯一标识
 *
 *  @return 假数据字典
 */
- (NSDictionary *)replaceDataFromFakeDataWithIdentifier:(LCFakeDataParams *)fakeDataParams;
/**
 *  拿到请求下来的数据，重组为UI层想要的形式
 *
 *  @param data 从网络请求下来的数据
 *
 */
- (void)recombinantDataWith:(NSDictionary *)data;

/**
 *  取消掉所有的请求
 */
- (void)cancelReformerAllOperations;
@end
