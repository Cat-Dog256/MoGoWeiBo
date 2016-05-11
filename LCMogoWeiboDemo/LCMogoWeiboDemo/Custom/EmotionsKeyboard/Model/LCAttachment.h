//
//  LCAttachment.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/11.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCEmotionModel;
@interface LCAttachment : NSTextAttachment
@property (nonatomic , strong) LCEmotionModel *emotion;
@end
