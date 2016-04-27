//
//  LCUserInfoModel.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCBaseModel.h"

/**
 *  {
 "id": 1404376560,
 "screen_name": "zaku",
 "name": "zaku",
 "province": "11",
 "city": "5",
 "location": "北京 朝阳区",
 "description": "人生五十年，乃如梦如幻；有生斯有死，壮士复何憾。",
 "url": "http://blog.sina.com.cn/zaku",
 "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",
 "domain": "zaku",
 "gender": "m",
 "followers_count": 1204,
 "friends_count": 447,
 "statuses_count": 2908,
 "favourites_count": 0,
 "created_at": "Fri Aug 28 00:00:00 +0800 2009",
 "following": false,
 "allow_all_act_msg": false,
 "geo_enabled": true,
 "verified": false,
 "status": {
 "created_at": "Tue May 24 18:04:53 +0800 2011",
 "id": 11142488790,
 "text": "我的相机到了。",
 "source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
 "favorited": false,
 "truncated": false,
 "in_reply_to_status_id": "",
 "in_reply_to_user_id": "",
 "in_reply_to_screen_name": "",
 "geo": null,
 "mid": "5610221544300749636",
 "annotations": [],
 "reposts_count": 5,
 "comments_count": 8
 },
 "allow_all_comment": true,
 "avatar_large": "http://tp1.sinaimg.cn/1404376560/180/0/1",
 "verified_reason": "",
 "follow_me": false,
 "online_status": 0,
 "bi_followers_count": 215
 }
 */
typedef enum{
    UserVerifiedTypeNone = -1,//平民
    
    UserVerifiedTypePersonal = 0,//个人认证
    
    UserVerifiedTypeOrgEnterprice = 2,
    UserVerifiedTypeOrgMedia = 3,//企业认证
    UserVerifiedTypeOrgWebsite = 5,
    
    UserVerifiedTypeDaren = 220
}UserVerifiedType;
@interface LCUserInfoModel : LCBaseModel
/**字符串型微博id*/
@property (nonatomic ,copy) NSString *idstr;
/**微博作者名字*/
@property (nonatomic , copy) NSString *name;
/**微博作者头像*/
@property (nonatomic , copy) NSString *profile_image_url;
/**会员类型 > 2是会员*/
@property (nonatomic , assign) int mbtype;
/**会员等级*/
@property (nonatomic , assign) int mbrank;

@property (nonatomic , assign , getter=isVip) BOOL vip;
/**注册类型*/
@property (nonatomic ,assign) UserVerifiedType verified_type;
@end
