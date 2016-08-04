//
//  LCParamsNullTool.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/30.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCParamsNullTool.h"

@implementation LCParamsNullTool
+ (void)writeToErrorMesLog:(NSString *)errorMes paramName:(NSString *)paramName{
    
    //拿到当前时间描述字符串
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *currentDate = [NSDate date];
    NSDate *correctCurrentDate = [currentDate dateByAddingTimeInterval:0];
    NSString *correcCurrentDateDes = [formatter stringFromDate:correctCurrentDate];
    
    //写入的消息
    NSString *msg = [NSString stringWithFormat:@"%@  %@  %@\n",correcCurrentDateDes,paramName,errorMes];
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    
    //写入的路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *newPath = [path stringByAppendingPathComponent:@"ErrorMes.log"];
    
    
    NSError *error;
    NSFileHandle *fp = [NSFileHandle fileHandleForWritingAtPath:newPath];
    if (fp == nil) {
        // 直接将 data 写入目标文件
        [data writeToFile:newPath atomically:YES];
        
    } else {
        // 1. 将文件 指针移动到文件末尾
        [fp seekToEndOfFile];
        //写入文件
        [fp writeData:data];
        
        [fp closeFile];
    }
    
    if(error){
        LCLogError(@"错误信息写入文件失败，原因：%@",error);
    }else{
        LCLogError(@"错误信息写入文件成功 \n%@",newPath);
    }
    
}

@end
