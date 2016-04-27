//
//  LCLabel.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/26.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCLabel.h"

@interface LCLabel ()
kLineAttributeDeclarations
@end

@implementation LCLabel
kLineMethodImplementation

+ (instancetype)labelWithFont:(int)font text:(NSString *)text{
    
    LCLabel *myLabel = [[LCLabel alloc] init];
    
    myLabel.text = text;
    
    myLabel.font = [UIFont systemFontOfSize:font];
    
    [myLabel sizeToFit];
    
    return myLabel;
}

- (instancetype)init{
    if (self = [super init]) {
        self.textColor = kMaxBlackColor;
        
        self.font = kMidTextFont;
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.textColor = kMaxBlackColor;
        
        self.font = kMidTextFont;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.textColor = kMaxBlackColor;
        
        self.font = kMidTextFont;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    kLineCalculationPosition
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
