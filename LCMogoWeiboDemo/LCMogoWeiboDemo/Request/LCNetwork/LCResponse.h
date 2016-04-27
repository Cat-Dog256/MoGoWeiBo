//
//  LCResponse.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/18.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LCResponse : NSObject
@property (nonatomic , strong) NSURLSessionDataTask *task;
@property (nonatomic , strong) NSString *responseString;
@property (nonatomic , strong) id responseObject;
@property (nonatomic , strong) NSError *error;
@property (nonatomic , strong) NSDictionary *userInfo;
@end
