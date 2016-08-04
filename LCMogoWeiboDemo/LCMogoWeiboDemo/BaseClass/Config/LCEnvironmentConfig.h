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
#define ENVIRON_INHOUSE              //预发测试环境
//#define ENVIRON_SIMULATED              //线上仿真环境
//#define ENVIRON_APPSTORE             //线上环境



//------------- 开发环境 ----------------
#ifdef ENVIRON_DEVELOP

#define kBaseUrl @"http://www.baidu.com"

//---------------- 内部测试环境 ----------------
#elif defined ENVIRON_INSIDE_TEST

#define kBaseUrl @"http://192.168.0.254/sunEdu/api/app"
#define kIpUrl @"http://192.168.0.254"
//#define kBaseUrl @"http://192.168.0.105:8080/api/app"

//-----------------预发测试环境----------------------
#elif defined ENVIRON_INHOUSE

#define kBaseUrl @"http://121.199.45.208/sunEdu/api/app"
#define kIpUrl @"http://121.199.45.208"

//#define kBaseUrl @"http://192.168.0.105:8080/api/app"

//---------------- 线上仿真环境 ----------------
#elif defined ENVIRON_SIMULATED

#define kBaseUrl @"http://sina.com"


//---------------- 线上环境 ----------------
#elif defined ENVIRON_APPSTORE

#define kBaseUrl @"http://sina.com"
#endif

#endif /* LCEnvironmentConfig_h */
