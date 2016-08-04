//
//  LCFileManagerTool.m
//  sunshineTeacher
//
//  Created by MoGo on 16/6/7.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCFileManagerTool.h"

@implementation LCFileManagerTool
+ (void)removeFile:(NSString*)fileName{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        DDLogError(@"%@ no have",fileName);
        return ;
    }else {
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
            DDLogInfo(@"dele %@ success",fileName);
        }else {
            DDLogError(@"dele %@ fail",fileName);
        }
        
    }
    
}

@end
