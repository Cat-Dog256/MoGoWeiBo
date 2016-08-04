//
//  LCRegularExtTool.h
//  sunshineTeacher
//
//  Created by MoGo on 16/6/7.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    kGetValues,//获取范围内的值
    kGetRanges //获取范围
}RegularType;

@interface LCRegularExtTool : NSObject
//你自己决定你需要判断的类型
+ (NSArray *)regularForYouWant:(NSString *)str pattern:(NSString *)pattern regularType:(RegularType)regularType;


/**判断邮箱格式*/
+ (BOOL) validateEmail:(NSString *)candidate;
/**判断手机号码*/
+ (BOOL) validateTelephone:(NSString *)candidate;
/**
 *  判读密码以字母开头，长度在6~18之间，只能包含字母、数字
 */
+ (BOOL) validatePassword:(NSString *)candidate;
//判断是不是正规的验证码
+ (NSArray *)regularAuthCode:(NSString *)codeStr regularType:(RegularType)regularType;

//判断是不是正规的手机号码
+ (NSArray *)regularTelephone:(NSString *)telStr regularType:(RegularType)regularType;
//判断是否是座机号
+ (NSArray *)regularPhone:(NSString *)phoneStr regularType:(RegularType)regularType;

//提取全部符合规范的手机号码，并返回
+ (NSArray *)regularTelephone2:(NSString *)telStr regularType:(RegularType)regularType;
//判断是不是联系方式
+ (NSArray *)regularTelephone3:(NSString *)telStr regularType:(RegularType)regularType;

//判断是否是标点符号
+ (NSArray *)regularMarks:(NSString *)marksStr regularType:(RegularType)regularType;

//邮箱地址
+ (NSArray *)regularEmail:(NSString *)emailStr regularType:(RegularType)regularType;
+ (NSArray *)regularEmail2:(NSString *)emailStr regularType:(RegularType)regularType;

//网址
+ (NSArray *)regularUrl:(NSString *)urlStr regularType:(RegularType)regularType;

//省份证
+ (NSArray *)regularIdentityCard: (NSString *)identityCard regularType:(RegularType)regularType;

//名字
+ (NSArray *)regularUserName:(NSString *)name regularType:(RegularType)regularType;

//昵称
+ (NSArray *)regularNickname:(NSString *)nickname regularType:(RegularType)regularType;

//收货人
+ (NSArray *)regularConnectName:(NSString *)name regularType:(RegularType)regularType;

//密码
+ (NSArray *)regularPassword:(NSString *)passWord regularType:(RegularType)regularType;

//车型
+ (NSArray *)regularCarType:(NSString *)carType regularType:(RegularType)regularType;

//车牌号
+ (NSArray *)regularCarNo:(NSString *)carNo regularType:(RegularType)regularType;

//检验是否包含表情
+(BOOL)regularStringContainsEmoji:(NSString *) string;

//检验是否包含特殊符号
+(BOOL)regularStringIncludeAddressSpecialCharact:(NSString *)string;
@end
