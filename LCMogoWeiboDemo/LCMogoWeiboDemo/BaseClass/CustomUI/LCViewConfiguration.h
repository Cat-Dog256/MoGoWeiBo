//
//  LCViewConfiguration.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/24.
//  Copyright © 2016年 李策. All rights reserved.
//

#ifndef LCViewConfiguration_h
#define LCViewConfiguration_h
#import "UIColor+Extension.h"

//项目的主题颜色 UI出图后确定 , 目前为测试
#define kYGTBaseColor kRGBCOLOR(69, 204, 170)
#define kMaxTextFont 17

//大字
#define kBigTextFont [UIFont systemFontOfSize:16]
//常规
#define kMidTextFont [UIFont systemFontOfSize:14]
//小字
#define kSmallTextFont [UIFont systemFontOfSize:12]
//背景灰色
#define kBgDarkColor [UIColor colorWithHexString:@"#efefef" alpha:1]

//背景白色
#define kBgWhiteColor [UIColor colorWithHexString:@"#FFFFFF" alpha:1]

//边框颜色
#define kBorderLineColor [UIColor colorWithHexString:@"#e4e4e4" alpha:1]
//边框粗细
#define kBorderLineThickness 0.8

//默认黑 用于默认黑色
#define kMaxBlackColor [UIColor colorWithHexString:@"#303030" alpha:1]

//中性黑 用于灰色
#define kMidBlackColor [UIColor colorWithHexString:@"#707070" alpha:1]

//浅黑 用于textField等placehorder文字颜色 还有时间
#define kMinBlackColor [UIColor colorWithHexString:@"#ababab" alpha:1]


//用于cell灰色
#define kCellBackGroundColor [UIColor colorWithHexString:@"#fafafa" alpha:1]
//cell边线粗细
#define kBorderCellLineThickness 8

//橙色
#define kOrangeColor [UIColor colorWithHexString:@"#ff9900" alpha:1]

//红色
#define kRedColor [UIColor colorWithHexString:@"#fd0305" alpha:1]

//橘红色
#define kHyacinthColor [UIColor colorWithHexString:@"#f95b03" alpha:1]

//蓝青色
#define kIndigoColor [UIColor colorWithHexString:@"#12acf2" alpha:1]

//绿色
#define kGreenColor [UIColor colorWithHexString:@"#56ba22" alpha:1]

//蓝色
#define kBlueColor [UIColor colorWithHexString:@"#4cbaff" alpha:1]



#endif /* LCViewConfiguration_h */
