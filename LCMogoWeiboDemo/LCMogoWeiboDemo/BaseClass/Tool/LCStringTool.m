//
//  LCStringTool.m
//  sunshineTeacher
//
//  Created by MoGo on 16/6/7.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCStringTool.h"

@implementation LCStringTool
#pragma mark rangeLabel
+ (NSMutableAttributedString *)rangeLabelWithContent:(NSString *)content hltContentArr:(NSArray *)hltContentArr hltColor:(UIColor *)hltColor normolColor:(UIColor *)normolColor{
    NSMutableArray *hltRangeArr = [NSMutableArray array];
    for (int i = 0;i < hltContentArr.count;i++){
        NSRange range = [content rangeOfString:[hltContentArr objectAtIndex:i]];
        if (range.location != NSNotFound){
            NSValue *rectValue = [NSValue valueWithBytes:&range  objCType:@encode(NSRange)];
            if (rectValue !=nil){
                [hltRangeArr addObject:rectValue];
            }
        }
    }
    NSMutableAttributedString *mutableAttributedString;
    if (content.length){
        mutableAttributedString = [[NSMutableAttributedString alloc]initWithString:content];
    }
    NSMutableArray *rangeTempMutableArr = [NSMutableArray array];
    NSRange zeroRange;
    zeroRange.length = 0;
    zeroRange.location = 0;
    NSValue *zeroRangeValue = [NSValue valueWithBytes:&zeroRange  objCType:@encode(NSRange)];
    [rangeTempMutableArr addObject:zeroRangeValue];
    
    for (int i = 0 ; i < hltRangeArr.count;i++){
        NSRange hltRange = [[hltRangeArr objectAtIndex:i] rangeValue];
        NSRange lastHltRange = [[rangeTempMutableArr lastObject] rangeValue];
        
        // normolRange
        NSRange normolRange;
        normolRange.location = lastHltRange.length + lastHltRange.location;
        normolRange.length = hltRange.location - normolRange.location;
        
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:hltColor range:hltRange];
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:normolColor range:normolRange];
        
        NSValue *rectValue = [NSValue valueWithBytes:&hltRange  objCType:@encode(NSRange)];
        [rangeTempMutableArr addObject:rectValue];
    }
    NSRange lastHltRange = [[rangeTempMutableArr lastObject] rangeValue];
    NSRange lastNormolRange;
    lastNormolRange.location = lastHltRange.length + lastHltRange.location;
    lastNormolRange.length = content.length - lastNormolRange.location;
    [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:normolColor range:lastNormolRange];
    return  mutableAttributedString;
}

+ (NSMutableAttributedString *)rangeLabelWithContent:(NSString *)content hltContentArr:(NSArray *)hltContentArr hltColor:(UIColor *)hltColor hltFont:(UIFont *)hltFont normolColor:(UIColor *)normolColor normalFont:(UIFont *)normalFont{
    NSMutableArray *hltRangeArr = [NSMutableArray array];
    for (int i = 0;i < hltContentArr.count;i++){
        NSRange range = [content rangeOfString:[hltContentArr objectAtIndex:i]];
        if (range.location != NSNotFound){
            NSValue *rectValue = [NSValue valueWithBytes:&range  objCType:@encode(NSRange)];
            if (rectValue !=nil){
                [hltRangeArr addObject:rectValue];
            }
        }
    }
    NSMutableAttributedString *mutableAttributedString;
    if (content.length){
        mutableAttributedString = [[NSMutableAttributedString alloc]initWithString:content];
    }
    NSMutableArray *rangeTempMutableArr = [NSMutableArray array];
    NSRange zeroRange;
    zeroRange.length = 0;
    zeroRange.location = 0;
    NSValue *zeroRangeValue = [NSValue valueWithBytes:&zeroRange  objCType:@encode(NSRange)];
    [rangeTempMutableArr addObject:zeroRangeValue];
    
    for (int i = 0 ; i < hltRangeArr.count;i++){
        NSRange hltRange = [[hltRangeArr objectAtIndex:i] rangeValue];
        NSRange lastHltRange = [[rangeTempMutableArr lastObject] rangeValue];
        
        // normolRange
        NSRange normolRange;
        normolRange.location = lastHltRange.length + lastHltRange.location;
        normolRange.length = hltRange.location - normolRange.location;
        
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:hltColor range:hltRange];
        [mutableAttributedString addAttribute:NSFontAttributeName value:hltFont range:hltRange];
        
        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:normolColor range:normolRange];
        [mutableAttributedString addAttribute:NSFontAttributeName value:normalFont range:normolRange];
        
        NSValue *rectValue = [NSValue valueWithBytes:&hltRange  objCType:@encode(NSRange)];
        [rangeTempMutableArr addObject:rectValue];
    }
    NSRange lastHltRange = [[rangeTempMutableArr lastObject] rangeValue];
    NSRange lastNormolRange;
    lastNormolRange.location = lastHltRange.length + lastHltRange.location;
    lastNormolRange.length = content.length - lastNormolRange.location;
    [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:normolColor range:lastNormolRange];
    [mutableAttributedString addAttribute:NSFontAttributeName value:normalFont range:lastNormolRange];
    return  mutableAttributedString;
}
+ (NSString *)deleleteSpaceAtendOfString:(NSString *)string{
    NSMutableString * outputString = [NSMutableString string];
    
    // NSStringEnumerationByWords：将string按空格分开，并且会自动清理首尾的空格
    // 这个方法会把中间多余的空格也清理掉，比如上面的字符串，s和d之间有两个空格，会变成一个空格
    [string enumerateSubstringsInRange:NSMakeRange(0, string.length) options:NSStringEnumerationByWords usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        [outputString appendFormat:@"%@ ",substring];
    }];
    
    // 删除我们添加的末尾的一个空格
    [outputString deleteCharactersInRange:NSMakeRange(outputString.length-1, 1)];
    
    return outputString;
}


+ (NSString *)turnBaseToBase10:(NSString *)base{
    int i = 0,j = 0;
    for (int k = 0; k<base.length; k++) {
        j = [[base substringWithRange:NSMakeRange(k, 1)] intValue];
        j= j *powf(2, base.length-k-1);
        i += j;
    }
    NSString *base10 = [NSString stringWithFormat:@"%d",i];
    return base10;
}
+ (NSString *)turnBase10ToBase16:(NSString *)base10{
    
    NSString * hexStr = [[NSString alloc] initWithFormat:@"%llx", [base10 longLongValue]];;
    return hexStr;
}

+ (NSString *)turnBaseToBase16:(NSString *)base{
    NSString *base10 = [[self class] turnBaseToBase10:base];
    return [[self class] turnBase10ToBase16:base10];
}
@end
