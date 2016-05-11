//
//  LCEmotionsConst.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/11.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  选中表情的通知
 */
extern NSString *const kLCEmotionKeyboardDidSelectedEmotiomNotification;
/**
 *  选中表情发送通知中userInfo字典中的key,value为表情模型
 */
extern NSString *const kSelectedEmotionInfo;
/**
 *  表情键盘删除按钮的通知
 */
extern NSString *const kLCEmotionKeyboardDidSelectedDeletedNotification;
/**
 *  表情键盘toolBar的高度
 */
extern CGFloat const EmotiontToolbarH;
/**
 *  表情键盘pageControl的高度
 */
extern CGFloat const PageControlH;
@interface LCEmotionsConst : NSObject

@end
