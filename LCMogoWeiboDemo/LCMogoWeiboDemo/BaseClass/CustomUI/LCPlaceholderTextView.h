//
//  LCPlaceholderTextView.h
//  SmartHome
//
//  Created by MoGo on 16/1/12.
//  Copyright © 2016年 MoGo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCPlaceholderTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
