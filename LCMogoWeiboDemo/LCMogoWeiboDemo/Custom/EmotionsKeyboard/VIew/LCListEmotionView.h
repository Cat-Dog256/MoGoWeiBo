//
//  LCListEmotionView.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/29.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCListEmotionView : UIView
/**
 *  表情模型数组
 */
@property (nonatomic , strong) NSArray *emmtionsModelArray;
/**
 *  偏移量设置为零
 */
- (void)reloadListEmotionsView;
@end
