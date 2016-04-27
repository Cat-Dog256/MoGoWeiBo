//
//  LCDBConst.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/21.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCDBConst.h"

@implementation LCDBConst

@end
#pragma mark - 表名
NSString * const kLCCacheTable = @"t_cache";

#pragma mark - 字段
//唯一标识
NSString * const kUniqueIdentifier = @"uniqueIden";
//主键
NSString * const kId = @"id";
//用户id
NSString * const kUserId = @"userid";
//content
NSString * const kContent = @"content";
//createTime
NSString * const kCreateTime = @"createTime";
// archivedType
NSString * const kCacheArchivedType = @"archivedType";
// kDictionary
NSString * const kCahceArchiverDictionary = @"Dictionary";
// kArray
NSString * const kCacheArchiverArray = @"Array";

#pragma mark - sql 语句用
//整句
//CREATE TABLE IF NOT EXISTS
NSString * const kCreateTableIfNotExists = @"CREATE TABLE IF NOT EXISTS";
//PRIMARY KEY AUTOINCREMENT
NSString * const kPrimaryKeyAutoIncrement = @"PRIMARY KEY AUTOINCREMENT";
//SELECT *FROM
NSString * const kSelectFrom = @"SELECT *FROM";
//DELETE FROM
NSString * const kDeleteFrom = @"DELETE FROM";
//INSERT INTO 插入
NSString * const kInsertInto = @"INSERT INTO";
//ORDER BY
NSString * const kOrderBy = @"ORDER BY";

//单分
//CREATE
NSString * const kCreate = @"CREATE";
//DROP
NSString * const kDrop = @"DROP";
//TABLE
NSString * const kTable = @"TABLE";
//IF
NSString * const kIf = @"IF";
//NOT
NSString * const kNot = @"NOT";
//EXISTS
NSString * const kExists = @"EXISTS";
//PRIMARY
NSString * const kPrimary = @"PRIMARY";
//KEY
NSString * const kKey = @"KEY";
//AUTOINCREMENT
NSString * const kAutoIncrement = @"AUTOINCREMENT";


//integer 整型
NSString * const kInteger = @"integer";
//text    字符串
NSString * const kText = @"text";
//blob    二进制
NSString * const kBlob = @"blob";
//real    浮点型
NSString * const kReal = @"real";

//CRUD
//INSERT
NSString * const kInsert = @"INSERT";
//INTO
NSString * const kInto = @"INTO";
//SELECT
NSString * const kSelect = @"SELECT";
//FROM
NSString * const kFrom = @"FROM";
//WHERE
NSString * const kWhere = @"WHERE";
//ORDER
NSString * const kOrder = @"ORDER";
//BY
NSString * const kBy = @"BY";
//DESC 排序降序
NSString * const kDesc = @"DESC";
//DELETE
NSString * const kDelete = @"DELETE";
//UPDATE
NSString * const kUpdate = @"UPDATE";
//SET
NSString * const kSet = @"SET";

//AND
NSString * const kAnd = @"AND";
//OR
NSString * const kOr = @"OR";
//VALUES
NSString * const kValues = @"VALUES";
//NULL
NSString * const kNull = @"NULL";
//UNIQUE
NSString * const kUnique = @"UNIQUE";
//LIMIT
NSString * const kLimit  = @"LIMIT";