//
//  LCStatusFrameModel.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/25.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCStatusFrameModel.h"
#import "LCPhotosView.h"
/**
 *  头像高宽
 */
NSUInteger const iconWidth = 40;
/**
 *  间距
 */
NSUInteger const BigMargin = 5;
/**
 *  昵称距离头像上边的高度
 */
NSUInteger const SmallMargin = 3;
/**
 *  左右间距
 */
NSUInteger const MaxMargin = 10;
@implementation LCStatusFrameModel
- (void)setStatusModel:(LCStatusesModel *)statusModel{
    _statusModel = statusModel;
    //头像
    CGFloat iconX = MaxMargin;
    CGFloat iconY = 0;
    self.iconViewF = CGRectMake(iconX, iconY, iconWidth, iconWidth);
   //昵称
    CGSize nameSize = [statusModel.userMessage.name sizeWithFont:kMidTextFont];
    CGFloat nameH = nameSize.height;
    CGFloat nameW = nameSize.width;
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + BigMargin;
    CGFloat nameY = SmallMargin;
    self.nameLabelF = CGRectMake(nameX, nameY, nameW, nameH);
    //vip图片
    if ([statusModel.userMessage isVip]) {
        self.vipViewF = CGRectMake(CGRectGetMaxX(self.nameLabelF), nameY, nameH, nameH);
    }
    
    /**时间*/
    NSDictionary *dictTime = @{NSFontAttributeName:kSmallTextFont};
    CGSize timeSize = [statusModel.created_at sizeWithAttributes:dictTime];
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.iconViewF) - timeSize.height - SmallMargin;

    self.timeLabelF = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    /**来源*/
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + BigMargin;
    CGFloat sourceY = timeY;
    
    CGSize sourceSize = [statusModel.source sizeWithAttributes:dictTime];
    
    self.sourceLabelF = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);

    /**正文*/
    CGFloat textX = iconX;
    CGFloat textY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + BigMargin;
    CGSize textSize = [statusModel.textString sizeWithFont:kMidTextFont maxW:SCREEN_WIDTH - 20];
    self.contentLabelF = CGRectMake(textX, textY, textSize.width, textSize.height);
    /**微博图片*/
    CGFloat originalH = 0;
    if (statusModel.pic_urls.count) {
#warning 计算原创微博配图Size
        
        CGSize picSize = [LCPhotosView photosViewSizeWithCount:(int)statusModel.pic_urls.count];
        
        
        CGFloat picX = iconX;
        CGFloat picY = CGRectGetMaxY(self.contentLabelF) + BigMargin;
        CGFloat picW = picSize.width;
        CGFloat picH = picSize.height;
        self.photoViewF = CGRectMake(picX, picY, picW, picH);
        originalH = CGRectGetMaxY(self.photoViewF) + BigMargin;
    }else{
        originalH = CGRectGetMaxY(self.contentLabelF) + BigMargin;
    }

    self.originalViewF = CGRectMake(0, MaxMargin + kBorderCellLineThickness, SCREEN_WIDTH - 2 * MaxMargin, originalH);
    CGFloat toolBarY = 0;
    if (statusModel.retweeted_status) {
        /**转发微博正文*/
        
        CGFloat retweetTextLabelX = iconX;
        CGFloat retweetTextLabelY = MaxMargin;
        NSString *contentText = [NSString stringWithFormat:@"%@ : %@",statusModel.retweeted_status.userMessage.name , statusModel.retweeted_status.textString];
        CGSize retTextSize = [contentText sizeWithFont:kMidTextFont maxW:SCREEN_WIDTH - 20];
        self.retweetTextLabelF = CGRectMake(retweetTextLabelX, retweetTextLabelY, retTextSize.width, retTextSize.height);
        /**转发配图*/
        CGFloat retweetViewH = 0;
        if (statusModel.retweeted_status.pic_urls.count) {
            
#warning 计算转发微博配图Size
            CGSize retPicSize = [LCPhotosView photosViewSizeWithCount:(int)statusModel.retweeted_status.pic_urls.count];
            
            
            CGFloat retPicX = iconX;
            CGFloat retPicY = CGRectGetMaxY(self.retweetTextLabelF) + MaxMargin;
            CGFloat retPicW = retPicSize.width;
            CGFloat retPicH = retPicSize.height;
            self.retweetPhotosViewF = CGRectMake(retPicX, retPicY, retPicW, retPicH);
            retweetViewH = CGRectGetMaxY(self.retweetPhotosViewF) + MaxMargin;
        }else{
            retweetViewH = CGRectGetMaxY(self.retweetTextLabelF) + MaxMargin;
        }
        /**转发微博整体*/
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetViewW =[UIScreen mainScreen].bounds.size.width;
        self.retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        /**toolBarY的高度*/
        toolBarY = CGRectGetMaxY(self.retweetViewF);
    }else{
        /**toolBarY的高度*/
        toolBarY = CGRectGetMaxY(self.originalViewF);
    }
    
    CGFloat toolBarX = 0;
    CGFloat toolBarW = [UIScreen mainScreen].bounds.size.width;
    CGFloat toolBarH = 35;
    self.toolBarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    /**cell高度*/
    self.cellHeight = CGRectGetMaxY(self.toolBarF);
}
@end
