//
//  LCGetVersionTool.m
//  sunshineTeacher
//
//  Created by MoGo on 16/6/7.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCGetVersionTool.h"

@interface LCGetVersionTool ()
@property (nonatomic,copy) void (^block)(NSDictionary *dic);
@end

@implementation LCGetVersionTool
- (void)getOnlineVersion:( void(^)(NSDictionary *dic) ) block{
    
    self.block = block;
    
    //id是App的唯一Id
    NSString *appId = @"";
    
    NSString *urlStr = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/lookup?id=%@",appId];
    
    [self postVersionUrl:urlStr];
}

- (void)postVersionUrl:(NSString *)urlStr
{
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *muRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    [muRequest setHTTPMethod:@"POST"];
    
    [[[NSURLSession sharedSession] downloadTaskWithRequest:muRequest completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSMutableDictionary *resultMuDic=[[NSMutableDictionary alloc]init];
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([dic[@"resultCount"] intValue]>0){
            //查到了appstore上的当前程序
            [resultMuDic setObject:@"1" forKey:@"status"];
            
            [resultMuDic setObject:[dic[@"results"] objectAtIndex:0] forKey:@"version"];
            
        }else{
            //没有查到appstore上的当前程序
            [resultMuDic setObject:@"-1" forKey:@"status"];
        }
        
        if (self.block) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.block(resultMuDic);
            }];
        }
        
    }] resume];
    
}

@end
