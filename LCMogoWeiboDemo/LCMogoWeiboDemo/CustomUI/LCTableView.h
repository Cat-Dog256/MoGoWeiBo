//
//  LCTableIView.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/24.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCTableView : UITableView
/**
 *  如果为空时的提示语
 */
@property (nonatomic,copy) NSString *promptStr;
/**
 *  如果为空时的显示图片
 */
@property (nonatomic,strong) UIImage *promptImage;

/**
 *  自主控制是否允许显示空界面
 */
@property (nonatomic,assign) BOOL isAllowShowNullView;
@end
