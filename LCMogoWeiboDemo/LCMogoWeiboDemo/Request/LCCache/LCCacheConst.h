//
//  LCCacheConst.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/21.
//  Copyright © 2016年 李策. All rights reserved.
//

#ifndef LCCacheConst_h
#define LCCacheConst_h

typedef enum{
    LCRequestCacheNone = 0,//无缓存
    LCRequestCacheDB,      //数据库缓存
    LCRequestCacheFile     //文件缓存
} LCRequestCachePolicy;

typedef enum{
    LCCacheExpiredTimeDefult = 0,    //默认时间
    LCCacheExpiredTimeNormal = 86400,//缓存一天
    LCCacheExpiredTimeForever        //永久缓存
} LCCacheExpiredTime;

#endif /* LCCacheConst_h */
