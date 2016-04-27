//
//  LCStatusesListReformer.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCStatusesListReformer.h"

@implementation LCStatusesListReformer
- (LCRequsestBase *)prepareRequest{
    self.myRequest.UrlString = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    self.myRequest.httpRequestMethod = GET;
    self.myRequest.identifier = self.identfier;
    

    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    
    //参数是否为空的判断
//    BOOL b = [self judgeParamsState:self.access_token paramName:@"access_token"];
//    if(!b){
//        return nil;
//    }
    
    [tempDic setObject:self.access_token forKey:@"access_token"];
    [self.myRequest.params addEntriesFromDictionary:tempDic];
    [super prepareRequest];
    
    return self.myRequest;
}

#pragma mark - 请求方法
- (void)requestDataWithHUDView:(UIView *)view
{
    //获得准备好的request
    LCRequsestBase *req = [self prepareRequest];
    req.cacheExpiredTime = LCCacheExpiredTimeDefult;
    req.cachePolicy = LCRequestCacheNone;
    //调用父类方法开始请求
    [self startWithRequest:req withView:view];
}
- (void)refreshDataWithPage:(NSUInteger)page{
    //获得准备好的request
    LCRequsestBase *req = [self prepareRequest];
    if (page == 1) {
        req.cacheExpiredTime = LCCacheExpiredTimeDefult;

        req.cachePolicy = LCRequestCacheDB;
    }else{
        req.cachePolicy = LCRequestCacheNone;
    }
    [req.params setObject:[NSNumber numberWithUnsignedInteger:page] forKey:@"page"];
    //刷新数据
    [self refreshDataWithRequest:req];
}
-(void)requestSuccess:(LCResponse *)response{

#ifdef ENVIRON_DEVELOP
    //封装假数据参数
    self.fakeDataParams.identifier = self.myRequest.identifier;
    self.fakeDataParams.secondIden = self.myRequest.secondIden;
    //取得假数据，并将response.responseDic替换为假数据
    response.responseObject = [self replaceDataFromFakeDataWithIdentifier:self.fakeDataParams];
#endif
    //重组数据
    [self recombinantDataWith:response.responseObject];
    [super requestSuccess:response];
}
- (void)requestFailure:(LCResponse *)response{
        [super requestFailure:response];
}
#pragma mark**读取缓存数据转换为模型数据**
- (void)getAppCache:(id)cacheDict{
    NSArray *array = cacheDict;
    [self changeDatasToModel:array];
}
#pragma mark - 从父类继承的方法，主要是重组数据,并把数据转换为模型
- (id)recombinantDataWith:(NSDictionary *)data
{
    [super recombinantDataWith:data];
    //外层model
    self.resultModel = [LCResultStatusesModel mj_objectWithKeyValues:data];

    NSArray *statuses = data[@"statuses"];

    [self changeDatasToModel:statuses];
    self.appCache.archivedType = kCacheArchiverArray;
    return statuses;
}
- (void)changeDatasToModel:(NSArray *)dataArray{
    NSArray *statusModelsArray = [LCStatusesModel mj_objectArrayWithKeyValuesArray:dataArray];

    NSMutableArray *frameModelslArray = [NSMutableArray array];
    for (LCStatusesModel *model in statusModelsArray) {
        LCStatusFrameModel *frameModel = [[LCStatusFrameModel alloc]init];
        frameModel.statusModel = model;
        [frameModelslArray addObject:frameModel];
    }
    
    self.statusesModels = frameModelslArray;
}
/**
 *  {
	attitudes_count = 2,
	textLength = 130,
	source = <a href="http://app.weibo.com/t/feed/4fuyNj" rel="nofollow">即刻笔记</a>,
	source_type = 1,
	idstr = 3968568427744592,
	mid = 3968568427744592,
	truncated = 0,
	darwin_tags = [
 ],
	source_allowclick = 0,
	original_pic = http://ww2.sinaimg.cn/large/941b8a89jw1f3a8weamkwj20c80h2jsu.jpg,
	in_reply_to_screen_name = ,
	comments_count = 0,
	hot_weibo_tags = [
 ],
	pic_urls = [
 {
	thumbnail_pic = http://ww2.sinaimg.cn/thumbnail/941b8a89jw1f3a8weamkwj20c80h2jsu.jpg
 }
 ],
	reposts_count = 0,
	isLongText = 0,
	favorited = 0,
	thumbnail_pic = http://ww2.sinaimg.cn/thumbnail/941b8a89jw1f3a8weamkwj20c80h2jsu.jpg,
	bmiddle_pic = http://ww2.sinaimg.cn/bmiddle/941b8a89jw1f3a8weamkwj20c80h2jsu.jpg,
	text_tag_tips = [
 ],
	geo = <null>,
	id = 3968568427744592,
	user = {
	id = 2484832905,
	bi_followers_count = 80,
	urank = 27,
	profile_image_url = http://tp2.sinaimg.cn/2484832905/50/5631811483/0,
	class = 1,
	verified_contact_email = ,
	province = 81,
	verified = 1,
	url = http://weibo.com/xingzuoer,
	statuses_count = 62178,
	geo_enabled = 1,
	follow_me = 0,
	description = 星座这玩意儿，怪得很~~关注@精选星座微博，为您网罗最给力的星座蜜语！！合作请私信,
	followers_count = 2266205,
	verified_contact_mobile = ,
	location = 香港 黄大仙区,
	mbrank = 4,
	avatar_large = http://tp2.sinaimg.cn/2484832905/180/5631811483/0,
	star = 0,
	verified_trade = 3549,
	profile_url = xingzuoer,
	weihao = ,
	online_status = 0,
	verified_contact_name = ,
	screen_name = 精选星座微博,
	verified_source_url = ,
	pagefriends_count = 0,
	name = 精选星座微博,
	verified_reason = 微博知名星座帐号,
	friends_count = 350,
	mbtype = 12,
	block_app = 1,
	avatar_hd = http://tva4.sinaimg.cn/crop.0.0.180.180.1024/941b8a89jw1e8qgp5bmzyj2050050aa8.jpg,
	credit_score = 80,
	remark = ,
	created_at = Tue Nov 22 16:28:09 +0800 2011,
	block_word = 0,
	allow_all_act_msg = 0,
	verified_state = 0,
	domain = xingzuoer,
	verified_reason_modified = ,
	allow_all_comment = 1,
	verified_level = 3,
	verified_reason_url = ,
	gender = f,
	favourites_count = 40,
	idstr = 2484832905,
	verified_type = 0,
	city = 8,
	verified_source = ,
	user_ability = 8,
	lang = zh-cn,
	ptype = 0,
	following = 1
 },
	in_reply_to_user_id = ,
	userType = 0,
	text = 我可能说不出真正的爱你是什么，我只知道当我开心、难过、自暴自弃的时候我希望那个陪我身边的人一直是你。十指相扣，就没有撑不起的明天。,
	biz_feature = 0,
	mlevel = 0,
	created_at = Tue Apr 26 17:45:08 +0800 2016,
	visible = {
	type = 0,
	list_id = 0
 },
	in_reply_to_status_id = ,
	rid = 0_0_1_2666872428199437934
 }
 */
@end
