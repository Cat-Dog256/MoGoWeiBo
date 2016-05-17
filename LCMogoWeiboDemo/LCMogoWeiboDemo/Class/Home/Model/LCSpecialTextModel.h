//
//  LCSpecialTextModel.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/16.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    specialUrl,
    specialAT,
    specialToptocal,
}specialType;
@interface LCSpecialTextModel : NSObject
@property (nonatomic , strong) NSString *text;
@property (nonatomic , assign) NSRange range;
@property (nonatomic , assign) specialType specialType;
@property (nonatomic , strong) NSArray *rects;
@end
