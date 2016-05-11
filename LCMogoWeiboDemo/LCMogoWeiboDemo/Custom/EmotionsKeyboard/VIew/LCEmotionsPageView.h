//
//  LCEmotionsPageView.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/9.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>
#define EmotionsPageMaxCols  7
#define EmotionsPageMaxRows  3
#define EmotionsPageCout (EmotionsPageMaxCols * EmotionsPageMaxRows - 1)

@interface LCEmotionsPageView : UIView
/**
 *  每一页的表情数组
 */
@property (nonatomic , strong) NSArray *pageEmotionsArray;
@end
