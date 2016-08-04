//
//  LCPoint2PointLine.m
//  sunshineTeacher
//
//  Created by MoGo on 16/6/7.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCPoint2PointLine.h"
@interface LCPoint2PointLine ()

@property (nonatomic,assign) CGPoint startPoint;
@property (nonatomic,assign) CGPoint endPoint;
@property (nonatomic,assign) CGFloat lineWidth;
@property (nonatomic,strong) UIColor *lineColor;

@end

@implementation LCPoint2PointLine
+ (instancetype)baseLineWithPoint1:(CGPoint)startPoint point2:(CGPoint)endPoint lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor{
    
    LCPoint2PointLine *line = [[LCPoint2PointLine alloc] init];
    
    line.startPoint = startPoint;
    
    line.endPoint = endPoint;
    
    line.lineWidth = lineWidth;
    
    line.lineColor = lineColor;
    
    return line;
}

- (void)setFrame:(CGRect)frame{
    return;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.frame = CGRectMake(0, 0, 0.1, 0.1);//虚拟
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    CGPoint startPoint = [self startPoint];
    CGPoint endPoint = [self endPoint];
    CGFloat lineWidth = [self lineWidth];
    UIColor *lineColor = [self lineColor];
    
    //    CGFloat margin = lineWidth * 0.5;
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    //(0,0)->(100,0)
    //    CGContextMoveToPoint(ref, startPoint.x, startPoint.y+margin);
    //    CGContextAddLineToPoint(ref, endPoint.x, endPoint.y+margin);
    
    //(0,0)->(0,100)
    //    CGContextMoveToPoint(ref, startPoint.x+margin, startPoint.y);
    //    CGContextAddLineToPoint(ref, endPoint.x+margin, endPoint.y);
    
    //(0, 400)->(200, 400)
    //    CGContextMoveToPoint(ref, startPoint.x, startPoint.y-margin);
    //    CGContextAddLineToPoint(ref, endPoint.x, endPoint.y-margin);
    
    //(200, 0)->(200, 400)
    //    CGContextMoveToPoint(ref, startPoint.x-margin, startPoint.y);
    //    CGContextAddLineToPoint(ref, endPoint.x-margin, endPoint.y);
    
    CGContextMoveToPoint(ref, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(ref, endPoint.x, endPoint.y);
    
    CGContextSetLineWidth(ref, lineWidth);
    [lineColor set];
    CGContextStrokePath(ref);
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.frame = self.superview.bounds;
}

@end
