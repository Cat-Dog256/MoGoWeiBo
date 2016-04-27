//
//  LCStatusFrameModel.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/25.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCStatusesModel.h"

@interface LCStatusFrameModel : NSObject
@property (nonatomic , strong) LCStatusesModel *statusModel;

/**原创微博整体*/
@property (nonatomic ,assign) CGRect originalViewF;
/**微博头像*/
@property (nonatomic , assign) CGRect iconViewF;
/**vip图片*/
@property (nonatomic , assign) CGRect vipViewF;
/**微博图片*/
@property (nonatomic ,assign) CGRect photoViewF;
/**昵称*/
@property (nonatomic , assign) CGRect nameLabelF;
/**时间*/
@property (nonatomic ,assign) CGRect timeLabelF;
/**来源*/
@property (nonatomic ,assign) CGRect sourceLabelF;
/**正文*/
@property (nonatomic , assign) CGRect contentLabelF;
/**转发微博整体*/
@property (nonatomic , assign)  CGRect retweetViewF;
/**转发微博正文*/
@property (nonatomic , assign) CGRect retweetTextLabelF;
/**转发配图*/
@property (nonatomic , assign) CGRect retweetPhotosViewF;
/**工具条*/
@property (nonatomic , assign) CGRect toolBarF;
/**cell的高度*/
@property (nonatomic , assign) CGFloat cellHeight;

@end
