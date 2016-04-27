//
//  LCEnvironmentConfig.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//

#ifndef LCEnvironmentConfig_h
#define LCEnvironmentConfig_h

//#define ENVIRON_DEVELOP              //开发环境
//#define ENVIRON_INSIDE_TEST          //内部测试环境
//#define ENVIRON_INHOUSE              //预发测试环境
//#define ENVIRON_SIMULATED              //线上仿真环境
#define ENVIRON_APPSTORE             //线上环境



//------------- 开发环境 ----------------
#ifdef ENVIRON_DEVELOP

#define kBaseUrl @"http://gc.ditu.aliyun.com/geocoding?a=%E4%BD%9B%E5%B1%B1"

//---------------- 内部测试环境 ----------------
#elif defined ENVIRON_INSIDE_TEST

#define kBaseUrl @"http://172.31.10.136:11002"

//-----------------预发测试环境----------------------
#elif defined ENVIRON_INHOUSE

#define kBaseUrl @"http://101.36.73.227:11002"

//---------------- 线上仿真环境 ----------------
#elif defined ENVIRON_SIMULATED

#define kBaseUrl @"http://sina.com"


//---------------- 线上环境 ----------------
#elif defined ENVIRON_APPSTORE

#define kBaseUrl @"http://sina.com"
#endif

#endif /* LCEnvironmentConfig_h */
