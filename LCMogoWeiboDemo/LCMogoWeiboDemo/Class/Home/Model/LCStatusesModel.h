//
//  LCStatusesModel.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCBaseModel.h"
#import "LCUserInfoModel.h"
@class LCStatusesModel;
@interface LCStatusesModel : LCBaseModel

/**字符串型微博id*/
@property (nonatomic ,copy) NSString *idstr;
/**微博信息内容*/
@property (nonatomic , strong) NSString *textString;
/**微博作者用户信息*/
@property (nonatomic , strong) LCUserInfoModel *userMessage;
/**	string	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/**	string	微博来源*/
@property (nonatomic, copy) NSString *source;

/**图片网址数组LCPicModel*/
@property (nonatomic , strong) NSArray *pic_urls;
@property (nonatomic , strong) NSString *bmiddle_pic;
@property (nonatomic , strong) NSString *original_pic;
/**转发微博内容*/
@property (nonatomic , strong) LCStatusesModel *retweeted_status;
/**	int	转发数*/
@property (nonatomic, assign) int reposts_count;
/**	int	评论数*/
@property (nonatomic, assign) int comments_count;
/**	int	表态数*/
@property (nonatomic, assign) int attitudes_count;
@end
