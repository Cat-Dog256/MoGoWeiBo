//
//  LCRegularExtTool.m
//  sunshineTeacher
//
//  Created by MoGo on 16/6/7.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import "LCRegularExtTool.h"

@implementation LCRegularExtTool
//你自己决定你需要判断的类型
+ (NSArray *)regularForYouWant:(NSString *)str pattern:(NSString *)pattern regularType:(RegularType)regularType{
    
    return [self regularTool4Values:pattern str:str regularType:regularType];
}

//判读邮箱
+ (BOOL) validateEmail:(NSString *)candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}
//判读密码以字母开头，长度在6~16之间，只能包含字符、数字和下划线^[a-zA-Z]\\w{5,17}$
+ (BOOL) validatePassword:(NSString *)candidate {
    NSString *passwordRegex = @"^[0-9_a-zA-Z]{6,16}$";//判读密码以字母开头，长度在6~18之间，只能包含字母、数字
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:candidate];
}
/**判断手机号码*/
+ (BOOL) validateTelephone:(NSString *)candidate{
    NSString *telephoneRegex = @"^[1][34578][0-9]{9}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telephoneRegex];
    return [emailTest evaluateWithObject:candidate];
}

//判断是不是正规的验证码
+ (NSArray *)regularAuthCode:(NSString *)codeStr regularType:(RegularType)regularType{
    
    NSString *pattern = @"^[0-9]{6}$";
    return [self regularTool4Values:pattern str:codeStr regularType:regularType];
}

//判断是不是正规的手机号码
+ (NSArray *)regularTelephone:(NSString *)telStr regularType:(RegularType)regularType{
    
    NSString *pattern = @"^[1][34578][0-9]{9}$";
    return [self regularTool4Values:pattern str:telStr regularType:regularType];
}

//判断是否是正规座机号码
+ (NSArray *)regularPhone:(NSString *)phoneStr regularType:(RegularType)regularType
{
    NSString *pattern = @"^(^0\\d{2}-?\\d{8}$)|(^0\\d{3}-?\\d{7}$)|(^\\(0\\d{2}\\)-?\\d{8}$)|(^\\(0\\d{3}\\)-?\\d{7}$)$";
    return [self regularTool4Values:pattern str:phoneStr regularType:regularType];
    
}

//判断是不是联系方式
+ (NSArray *)regularTelephone3:(NSString *)telStr regularType:(RegularType)regularType{
    
    NSString *pattern = @"^[0-9]{7,15}$";
    return [self regularTool4Values:pattern str:telStr regularType:regularType];
}

//判断是否是空格，汉字，数字，字母，标点符号
+ (NSArray *)regularMarks:(NSString *)marksStr regularType:(RegularType)regularType{
    
    NSString *pattern = @"^[\u4e00-\u9fa5,\u3000-\u301e,\ufe10-\ufe19,\ufe30-\ufe44,\ufe50-\ufe6b,\uff01-\uffee,\\u0020,a-z,A-Z,0-9,\\-,\\/,\\|,\\$,\\+,\\%,\\&,\\',\\(,\\),\\*,\\x20-\\x2f,\\x3a-\\x40,\\x5b-\\x60,\\x7b-\\x7e,\\x80-\\xff,\u3000-\u3002,\u300a,\u300b,\u300e-\u3011,\u2014,\u2018,\u2019,\u201c,\u201d,\u2026,\u203b,\u25ce,\uff01-\uff5e,\uffe5]+$";
    return [self regularTool4Values:pattern str:marksStr regularType:regularType];
    
}

//提取全部符合规范的手机号码，并返回
+ (NSArray *)regularTelephone2:(NSString *)telStr regularType:(RegularType)regularType{
    
    NSString *pattern = @"[1][358][0-9]{9}";
    return [self regularTool4Values:pattern str:telStr regularType:regularType];
}

//判断是不是正规的邮箱地址
+ (NSArray *)regularEmail:(NSString *)emailStr regularType:(RegularType)regularType{
    
    NSString *pattern = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$";
    return [self regularTool4Values:pattern str:emailStr regularType:regularType];
}
//提取全部符合规范的邮箱，并返回
+ (NSArray *)regularEmail2:(NSString *)emailStr regularType:(RegularType)regularType{
    
    NSString *pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self regularTool4Values:pattern str:emailStr regularType:regularType];
}


+ (NSArray *)regularUrl:(NSString *)urlStr regularType:(RegularType)regularType{
    
    NSString *pattern = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    return [self regularTool4Values:pattern str:urlStr regularType:regularType];
}



//身份证号
+ (NSArray *)regularIdentityCard: (NSString *)identityCard regularType:(RegularType)regularType{
    
    NSString *pattern = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [self regularTool4Values:pattern str:identityCard regularType:regularType];
}

//用户名
+ (NSArray *)regularUserName:(NSString *)name regularType:(RegularType)regularType{
    
    NSString *pattern = @"^[A-Za-z0-9]{6,20}+$";
    return [self regularTool4Values:pattern str:name regularType:regularType];
}

//收货人

+ (NSArray *)regularConnectName:(NSString *)name regularType:(RegularType)regularType{
    
    NSString *pattern = @"^[\u4e00-\u9fa5a-zA-Z]+$";
    return [self regularTool4Values:pattern str:name regularType:regularType];
}


//昵称
+ (NSArray *)regularNickname:(NSString *)nickname regularType:(RegularType)regularType{
    
    NSString *pattern = @"^[\u4e00-\u9fa5]{4,8}$";
    return [self regularTool4Values:pattern str:nickname regularType:regularType];
}

//密码
+ (NSArray *)regularPassword:(NSString *)passWord regularType:(RegularType)regularType{
    
    NSString *pattern = @"^[a-zA-Z0-9]{6,20}+$";
    return [self regularTool4Values:pattern str:passWord regularType:regularType];
}

//车型
+ (NSArray *)regularCarType:(NSString *)carType regularType:(RegularType)regularType{
    
    NSString *pattern = @"^[\u4E00-\u9FFF]+$";
    return [self regularTool4Values:pattern str:carType regularType:regularType];
}

//车牌号
+ (NSArray *)regularCarNo:(NSString *)carNo regularType:(RegularType)regularType{
    
    NSString *pattern = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    return [self regularTool4Values:pattern str:carNo regularType:regularType];
}


//返回values或ranges
+ (NSArray *)regularTool4Values:(NSString *)pattern str:(NSString *)str regularType:(RegularType)regularType{
    
    /*
     NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
     NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
     return [passWordPredicate evaluateWithObject:nickname];
     */
    
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionAnchorsMatchLines error:NULL];
    
    if(!str){
        return nil;
    }
    NSArray *array =  [regular matchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, str.length)];
    
    if(array.count == 0){
        return nil;
    }
    
    NSMutableArray *valueArr = [NSMutableArray array];
    
    if(regularType == kGetValues){
        
        for (NSTextCheckingResult *result in array) {
            NSString *subStr = [str substringWithRange:result.range];
            [valueArr addObject:subStr];
        }
        return valueArr;
    }
    
    if(regularType == kGetRanges){
        
        for (NSTextCheckingResult *result in array) {
            
            NSValue *value = [NSValue valueWithRange:result.range];
            [valueArr addObject:value];
        }
        return valueArr;
    }
    
    return nil;
}
//检验是否包含表情
+(BOOL)regularStringContainsEmoji:(NSString *) string{
    
    __block BOOL returnValue = NO;
    
    //((hs >= 0x20) && (hs <= 0x30)) || ((hs >= 0x40) && (hs <= 0x5F))||   数字0-9是0x30-0x39  图片16进制码与数字一样  0x20是空格
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                
                                LCLogWarn(@"%hu",hs);
                                
                                if((hs == 0x0) || (hs == 0x9) || (hs == 0xA) ||
                                   (hs == 0xD) || ((hs >= 0x21) && (hs <= 0x29)) || hs == 0x260e || ((hs >= 0xE000) && (hs <= 0xFFFD)) || ((hs >= 0x10000)&& (hs <= 0x10FFFF))){
                                    
                                    returnValue = YES;
                                }
                                
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                                
                            }];
    
    return returnValue;
    
    
}

//检验是否包含特殊符号   使用这个方法需要注意 当被检测字符串为空时 返回也为真
+(BOOL)regularStringIncludeAddressSpecialCharact:(NSString *)string{
    
    if (!string || string.length == 0) {
        return NO;
    }
    
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [string rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》{}【】[]^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*——+|《》$_€"]];
    
    if (urgentRange.location == NSNotFound){
        return NO;
    }
    return YES;
}


@end
