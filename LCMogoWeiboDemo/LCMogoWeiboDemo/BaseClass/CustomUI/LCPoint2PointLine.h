//
//  LCPoint2PointLine.h
//  sunshineTeacher
//
//  Created by MoGo on 16/6/7.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCPoint2PointLine : UIView
+ (instancetype)baseLineWithPoint1:(CGPoint)startPoint point2:(CGPoint)endPoint lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;
@end
