//
//  LCDBConst.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/21.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCDBConst : NSObject

@end
//缓存表
extern NSString * const kLCCacheTable;

//************************************************
//字段

//主键
extern NSString * const kId;
//唯一标识
extern NSString * const kUniqueIdentifier;
//用户id
extern NSString * const kUserId;
//json
extern NSString * const kJson;
//createTime
extern NSString * const kCreateTime;
// jsonType
extern NSString * const kJsonType;
// NSDictionary
extern NSString * const kCahceDictionary;
// NSArray
extern NSString * const kCacheArray;

//************************************************
//整句
//CREATE TABLE IF NOT EXISTS
extern NSString * const kCreateTableIfNotExists;
//PRIMARY KEY AUTOINCREMENT
extern NSString * const kPrimaryKeyAutoIncrement;
//SELECT *FROM
extern NSString * const kSelectFrom;
//DELETE FROM
extern NSString * const kDeleteFrom;
//INSERT INTO
extern NSString * const kInsertInto;
//REPLACE INTO 插入
extern NSString * const kReplaceInto;
//ORDER BY
extern NSString * const kOrderBy;

//单分
//CREATE
extern NSString * const kCreate;
//DROP
extern NSString * const kDrop;
//TABLE
extern NSString * const kTable;
//IF
extern NSString * const kIf;
//NOT
extern NSString * const kNot;
//EXISTS
extern NSString * const kExists;
//PRIMARY
extern NSString * const kPrimary;
//KEY
extern NSString * const kKey;
//AUTOINCREMENT
extern NSString * const kAutoIncrement;


//integer 整型
extern NSString * const kInteger;
//text    字符串
extern NSString * const kText;
//blob    二进制
extern NSString * const kBlob;
//real    浮点型
extern NSString * const kReal;

//CRUD
//INSERT INTO
extern NSString * const kInsert;
//INTO
extern NSString * const kInto;
//SELECT
extern NSString * const kSelect;
//FROM
extern NSString * const kFrom;
//WHERE
extern NSString * const kWhere;
//ORDER
extern NSString * const kOrder;
//BY
extern NSString * const kBy;
//DESC 排序降序
extern NSString * const kDesc;
//DELETE
extern NSString * const kDelete;
//UPDATE
extern NSString * const kUpdate;
//SET
extern NSString * const kSet;

//AND
extern NSString * const kAnd;
//OR
extern NSString * const kOr;
//VALUES
extern NSString * const kValues;
//NULL
extern NSString * const kNull;
//UNIQUE
extern NSString * const kUnique;
//LIMIT
extern NSString * const kLimit;