//
//  LCStatusCell.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/25.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCStatusCell.h"
#import "LCHearderIconView.h"
#import "LCPhotosView.h"
#import "LCToolBar.h"
/**
 *  间距
 */
NSUInteger const Big_Margin = 5;
@interface LCStatusCell ()
/**原创微博整体*/
@property (nonatomic , weak) UIView *originalView;
/**微博头像*/
@property (nonatomic , weak) LCHearderIconView *iconView;
/**vip图片*/
@property (nonatomic , weak) UIImageView *vipView;
/**微博图片*/
@property (nonatomic ,weak) LCPhotosView *photoView;
/**昵称*/
@property (nonatomic , weak) LCLabel *nameLabel;
/**时间*/
@property (nonatomic ,weak) LCLabel *timeLabel;
/**来源*/
@property (nonatomic ,weak) LCLabel *sourceLabel;
/**正文*/
@property (nonatomic , weak) LCLabel *contentLabel;




/**转发微博整体*/
@property (nonatomic , weak) UIView *retweetView;
/**转发微博正文*/
@property (nonatomic , weak) UILabel *retweetTextLabel;
/**转发配图*/
@property (nonatomic , weak) LCPhotosView *retweetPhotosView;

/**工具条*/
@property (nonatomic , weak) LCToolBar *toolBar;

@end

@implementation LCStatusCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpOriginalView];
        [self setUpRetweetView];
        [self setUpToolBar];

    }
    return self;
}
/**初始化工具条*/
- (void)setUpToolBar{
    LCToolBar *toolBar = [LCToolBar toolBar];
    [self.contentView addSubview:toolBar];
    self.toolBar = toolBar;
}

- (void)setUpOriginalView{
    /**原创微博整体*/
    UIView *originalView = [[UIView alloc]init];
     [self.contentView addSubview:originalView];
    
    self.originalView = originalView;
    /**微博头像*/
    LCHearderIconView *iconView = [[LCHearderIconView alloc]init];
    
    [originalView addSubview:iconView];
    self.iconView = iconView;
    /**vip图片*/
    UIImageView *vipView = [[UIImageView alloc]init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    
    self.vipView = vipView;
    /**微博图片*/
    LCPhotosView *photoView = [[LCPhotosView alloc]init];
    [originalView addSubview:photoView];
    
    self.photoView = photoView;
    /**昵称*/
    LCLabel *nameLabel = [[LCLabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = kOrangeColor;
    [originalView addSubview:nameLabel];
    
    self.nameLabel = nameLabel;
    /**时间*/
    LCLabel *timeLabel = [[LCLabel alloc]init];
    timeLabel.font = kSmallTextFont;
    timeLabel.textColor = kMinBlackColor;
    [originalView addSubview:timeLabel];
    
    self.timeLabel = timeLabel;
    /**来源*/
    LCLabel *sourceLabel = [[LCLabel alloc]init];
    sourceLabel.font = kSmallTextFont;
    sourceLabel.textColor = kMinBlackColor;
    [originalView addSubview:sourceLabel];
    
    self.sourceLabel = sourceLabel;
    /**正文*/
    LCLabel *contentLabel = [[LCLabel alloc]init];
    contentLabel.font = kMidTextFont;
    contentLabel.numberOfLines = 0;
    [originalView addSubview:contentLabel];
    
    self.contentLabel = contentLabel;
}

/**初始化转发微博*/
- (void)setUpRetweetView{
    UIView *retweetView = [[UIView alloc]init];
    retweetView.backgroundColor = kCellBackGroundColor;
    [self.contentView addSubview:retweetView];
    //    retweetView.backgroundColor = [UIColor redColor];
    self.retweetView = retweetView;
    /**转发微博正文*/
    UILabel *retweetTextLabel = [[UILabel alloc]init];
    retweetTextLabel.numberOfLines = 0;
    retweetTextLabel.font = kMidTextFont;
    [retweetView addSubview:retweetTextLabel];
    self.retweetTextLabel = retweetTextLabel;
    /**转发配图*/
    LCPhotosView *retweetPhotosView = [[LCPhotosView alloc]init];
    [retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
}

- (void)setFrameModel:(LCStatusFrameModel *)frameModel{
    _frameModel = frameModel;
    LCStatusesModel *statusModel = frameModel.statusModel;
    self.originalView.frame = frameModel.originalViewF;
    /**
     *  头像
     */
    self.iconView.frame = frameModel.iconViewF;
    self.iconView.userModel = statusModel.userMessage;
    /**
     *  昵称
     */
    self.nameLabel.frame = frameModel.nameLabelF;
   
    self.nameLabel.text = statusModel.userMessage.name;
    /**vip图片*/
    self.vipView.frame = frameModel.vipViewF;
    if (statusModel.userMessage.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = frameModel.vipViewF;
        NSString *iconName = [NSString stringWithFormat:@"common_icon_membership_level%d",statusModel.userMessage.mbrank];
        self.vipView.image = [UIImage imageNamed:iconName];
        self.nameLabel.textColor = kOrangeColor;
    }else{
        self.nameLabel.textColor = kMaxBlackColor;
        self.vipView.hidden = YES;
    }
    /**
     *  时间
     */
    self.timeLabel.frame = frameModel.timeLabelF;
//    self.timeLabel.text = statusModel.created_at;
    /**
     *  来源
     */
    self.sourceLabel.frame = frameModel.sourceLabelF;
//    self.sourceLabel.text = statusModel.source;
    /**
     *  正文
     */
    self.contentLabel.frame = frameModel.contentLabelF;
    self.contentLabel.text = statusModel.textString;
    
    /**微博图片*/
    self.photoView.frame = frameModel.photoViewF;
    //    self.photoView.backgroundColor = [UIColor redColor];
    if (statusModel.pic_urls.count) {
#pragma mark**设置微博配图**
        self.photoView.photosArray = statusModel.pic_urls;
        
        
        //        NSString *picUrl = [[staus.pic_urls firstObject]thumbnail_pic];
        //         [self.photoView sd_setImageWithURL:[NSURL URLWithString:picUrl]  placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.hidden = NO;
    }else{
        self.photoView.hidden = YES;
    }

#pragma mark**时间更改后文字长度发生改变 ， 要重新计算文字长度**
    /**时间*/
    NSString *timeString = statusModel.created_at;
    CGSize timeSize = [timeString sizeWithFont:kSmallTextFont];
    CGFloat timeX = frameModel.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(frameModel.nameLabelF) + Big_Margin;
    
    self.timeLabel.frame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    self.timeLabel.text = statusModel.created_at;
    
    /**来源*/
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + Big_Margin;
    CGFloat sourceY = timeY;
    NSString *sourceString = statusModel.source;
    CGSize sourceSize = [sourceString sizeWithFont:kSmallTextFont];
    
    self.sourceLabel.frame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    self.sourceLabel.text = statusModel.source;
    
    
    
    if (statusModel.retweeted_status) {
        self.retweetView.hidden = NO;
        /**转发微博整体*/
        self.retweetView.frame = frameModel.retweetViewF;
        /**转发微博正文*/
        self.retweetTextLabel.frame = frameModel.retweetTextLabelF;
        NSString *contentText = [NSString stringWithFormat:@"%@ : %@",statusModel.retweeted_status.userMessage.name , statusModel.retweeted_status.textString];
        self.retweetTextLabel.text = contentText;
        /**转发配图*/
        if (statusModel.retweeted_status.pic_urls.count) {
            self.retweetPhotosView.hidden = NO;
            self.retweetPhotosView.frame = frameModel.retweetPhotosViewF;
            
            
            //            NSString *picUrl = [[staus.retweeted_status.pic_urls firstObject]thumbnail_pic];
#pragma mark**设置转发微博配图**
            self.retweetPhotosView.photosArray = statusModel.retweeted_status.pic_urls;
            //            [self.retweetPhotosView sd_setImageWithURL:[NSURL URLWithString:picUrl]  placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            
        }else{
            self.retweetPhotosView.hidden = YES;
        }
        
    }else{
        self.retweetView.hidden = YES;
    }
    /**工具条*/
    self.toolBar.frame = frameModel.toolBarF;
    self.toolBar.statusesModel = frameModel.statusModel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
