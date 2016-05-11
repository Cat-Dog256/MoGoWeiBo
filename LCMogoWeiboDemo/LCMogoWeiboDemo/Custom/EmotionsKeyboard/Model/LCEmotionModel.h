//
//  LCEmotionModel.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/30.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCBaseModel.h"

@interface LCEmotionModel : LCBaseModel<NSCoding>
/**
 *  文字描述
 */
@property (nonatomic , strong) NSString *chs;
/**
 *  图片名字
 */
@property (nonatomic , strong) NSString *png;
/**
 *  emoji表情编码
 */
@property (nonatomic , strong) NSString *code;
@end
