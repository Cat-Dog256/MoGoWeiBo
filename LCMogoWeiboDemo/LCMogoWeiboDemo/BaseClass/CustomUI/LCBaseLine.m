//
//  LCBaseLine.m
//  sunshineTeacher
//
//  Created by MoGo on 16/6/7.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCBaseLine.h"

@implementation LCBaseLine
+ (instancetype)standardBaseLine{
    
    LCBaseLine *line = [[LCBaseLine alloc] init];
    
    return line;
}



- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = kBorderLineColor;
        self.height = kBorderLineThickness;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
