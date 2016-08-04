//
//  LCShowTopTool.h
//  sunshineTeacher
//
//  Created by MoGo on 16/6/7.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCShowTopTool : NSObject
/**
 *  从window上面加一个下拉 展示完移除 需要传入当前view 与显示的信息
 *
 *  @param currentView 当前view
 *  @param message     显示的信息
 */
-(void)showTopFromView:(UIView *)currentView withMessage:(NSString *)message;

-(instancetype)init;

//监测动画是否完成
@property (nonatomic,assign) BOOL isCompleted;
@end
