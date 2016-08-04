//
//  LCStringTool.h
//  sunshineTeacher
//
//  Created by MoGo on 16/6/7.
//  Copyright © 2016年 李策--MoGo--. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCStringTool : NSObject
/**
 *
 *
 *  @param content       需要处理的字符串
 *  @param hltContentArr 高亮字体
 *  @param hltColor      高亮字体的颜色
 *  @param normolColor   正常字体的颜色
 *
 *  @return 返回带属性的字符串
 */
+ (NSMutableAttributedString *)rangeLabelWithContent:(NSString *)content hltContentArr:(NSArray *)hltContentArr hltColor:(UIColor *)hltColor normolColor:(UIColor *)normolColor;
/**
 *
 *
 *  @param content       字符串
 *  @param hltContentArr 高亮字的数组
 *  @param hltColor      高亮颜色
 *  @param hltFont       高亮字体大小
 *  @param normolColor   正常字体颜色
 *  @param normalFont    正常字体颜色
 *
 *  @return 返回带属性的字符串
 */
+ (NSMutableAttributedString *)rangeLabelWithContent:(NSString *)content hltContentArr:(NSArray *)hltContentArr hltColor:(UIColor *)hltColor hltFont:(UIFont *)hltFont normolColor:(UIColor *)normolColor normalFont:(UIFont *)normalFont;
/**
 *  删除字符串结尾的空格
 */
+ (NSString *)deleleteSpaceAtendOfString:(NSString *)string;
/**
 *  二进制转十进制
 */
+ (NSString *)turnBaseToBase10:(NSString *)base;
/**
 *  十进制转16进制
 */
+ (NSString *)turnBase10ToBase16:(NSString *)base10;
/**
 *  二进制转十六进制
 **/
+ (NSString *)turnBaseToBase16:(NSString *)base;
@end
