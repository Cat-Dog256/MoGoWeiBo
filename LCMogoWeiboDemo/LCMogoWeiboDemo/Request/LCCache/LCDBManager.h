//
//  LCDBManager.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/21.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCDBConst.h"
@interface LCDBManager : NSObject
+ (instancetype) sharedManager;

/**
 *  建表
 *
 *  @param tableName 表名
 *  @param keyTypes  表包含的字段与字段类型 字段为key
 *
 *  @return          是否建表成功
 */
- (BOOL)createTable:(NSString *)tableName
           keyTypes:(NSDictionary *)keyTypes;
/**
 *  向表中插入数据
 *
 *  @param tableName 表名
 *  @param keyValues 字段名与其所对应的值 字段为key
 *
 *  @return          是否插入成功
 */

- (BOOL)insertDataIntoTable:(NSString *)tableName
                  keyValues:(NSDictionary *)keyValues;

/**
 *  删除某一行数据
 *
 *  @param tableName 表名
 *  @param condition 删除条件  字段名与其对应的值，其中的key为 字段名 + 运算符 e.g. "identifier >"
 *
 *  @return 是否成功
 */
- (BOOL)deleteDataFromTable:(NSString *)tableName
            singleCondition:(NSDictionary *)condition;
/**
 *  删除所有数据
 *
 *  @param tableName 表名
 *
 *  @return 是否成功
 */
- (BOOL) deleteAllDataFromTable:(NSString *)tableName;
/**
 *  单条件更新   where condition = ？；
 *
 *  @param tableName 表名称
 *  @param keyValues 要更新的字段及对应值 字段为key
 *  @param condition 条件 key的形式为 '字段 >'
 *
 *  @return 是否插入成功
 */
-(BOOL)updateTable:(NSString *)tableName
      setKeyValues:(NSDictionary *)keyValues
   singleCondition:(NSDictionary *)condition;

/**
 *  单条件查询数据库中的数据
 *
 *  @param keysTypes 查询字段以及对应字段类型 字典
 *  @param tableName 表名称
 *  @param condition 条件 key的形式为 '字段 >'
 *  @param page      页数
 *  @param count     每页数量
 *  @param isPage    是否按照页数取数据，如果不按照页数去数据page就为实际的数据个数，如果按照页数去数据page就为第几页数据
 *
 *  @return 查询得到数据
 */
- (NSArray *)selectKeyTypes:(NSDictionary *)keyTypes
                  fromTable:(NSString *)tableName
            singleCondition:(NSDictionary *)condition
                       page:(NSNumber *)page
                      count:(NSNumber *)count
                     isPage:(BOOL)isPage;

/**
 *  单条件查询
 *
 *  @param keyTypes  需要这一行的某个数据 字段及其对应的类型(要什么数据)
 *  @param tableName 表名
 *  @param condition 查询条件的字段名及其对应的值，其中的key为 字段名 + 运算符 e.g. "identifier >"
 *
 *  @return 一个字典数组，每个字典都是是一个以字段为key，这一行的这个字段对应的数据为值的的字典
 */
- (NSArray *)selectKeyTypes:(NSDictionary *)keyTypes
                  fromTable:(NSString *)tableName
            singleCondition:(NSDictionary *)condition;

/**
 *  根据一个字段的一个值来判断是否存在这行数据
 *
 *  @param tableName 表名
 *  @param key       字段
 *  @param value     字段对应的值
 *
 *  @return 是否存在
 */
- (BOOL)isExistsRowWithTableName:(NSString *)tableName
                       fieldName:(NSString *)fieldName
                           value:(NSString *)value;

/**
 *  检查是否存在某个表
 *
 *  @param tableName 表名
 *
 *  @return 是否存在
 */
- (BOOL)isExistsTable:(NSString *)tableName;
/**
 *  数据库是否打开
 *
 *  @return 是否打开
 */
- (BOOL)isOpen;

@end
