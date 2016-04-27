//
//  LCToolBar.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/27.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCToolBar.h"
#import "LCStatusesModel.h"
@interface LCToolBar ()
/**转发*/
@property (nonatomic , weak) UIButton *repostButton;
/**评论*/
@property (nonatomic , weak) UIButton *commentButton;
/**点赞*/
@property (nonatomic , weak) UIButton *attitudeButton;
/** 里面存放所有的分割线 */
@property (nonatomic, strong) NSMutableArray *dividers;
/** 里面存放所有的按钮 */
@property (nonatomic, strong) NSMutableArray *btns;

@end

@implementation LCToolBar
- (NSMutableArray *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (NSMutableArray *)dividers{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}
+ (instancetype)toolBar
{
    return [[self alloc]init];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
       
        self.repostButton = [self setUpToolBarButtonWithImage:@"timeline_icon_retweet" andTitleButton:@"转发"];
        
        self.commentButton = [self setUpToolBarButtonWithImage:@"timeline_icon_comment" andTitleButton:@"评论"];
        
        self.attitudeButton = [self setUpToolBarButtonWithImage:@"timeline_icon_unlike" andTitleButton:@"赞"];
        
        
        [self setupDivider];
        
        [self setupDivider];
        
    }
    
    return self;
}
- (UIButton *)setUpToolBarButtonWithImage:(NSString *)imagName andTitleButton:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imagName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    button.imageEdgeInsets = UIEdgeInsetsMake(0,0, 0, 10);
    button.titleLabel.font = kSmallTextFont;
    [button setTitleColor:kMinBlackColor forState:UIControlStateNormal];
    [self addSubview:button];
    
    [self.btns addObject:button];
    return button;
}
/**
 * 添加分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    int i = 0;
    for (UIButton *button in self.btns) {
        button.frame = CGRectMake(i * SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, self.frame.size.height);
        i++;
    }
    int j = 1;
    for (UIImageView *imageV in self.dividers) {
        imageV.frame = CGRectMake(j * SCREEN_WIDTH/3, 0,1, self.frame.size.height);
        j++;
    }
}
- (void)setStatusesModel:(LCStatusesModel *)statusesModel{
    _statusesModel = statusesModel;
    if (statusesModel.reposts_count) {
        [self.repostButton setTitle:[NSString stringWithFormat:@"%d",statusesModel.reposts_count] forState:UIControlStateNormal];
    }else{
        [self.repostButton setTitle:@"转发" forState:UIControlStateNormal];
    }
    
    if (statusesModel.comments_count) {
        [self.commentButton setTitle:[NSString stringWithFormat:@"%d",statusesModel.comments_count] forState:UIControlStateNormal];
    }else{
        [self.commentButton setTitle:@"评论" forState:UIControlStateNormal];
    }
    
    
    if (statusesModel.attitudes_count) {
        [self.attitudeButton setTitle:[NSString stringWithFormat:@"%d",statusesModel.attitudes_count] forState:UIControlStateNormal];
    }else{
        [self.attitudeButton setTitle:@"赞" forState:UIControlStateNormal];
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
