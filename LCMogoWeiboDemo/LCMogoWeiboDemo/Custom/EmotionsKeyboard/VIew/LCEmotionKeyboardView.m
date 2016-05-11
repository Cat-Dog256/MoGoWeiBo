//
//  LCEmotionKeyboardView.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/29.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCEmotionKeyboardView.h"
#import "LCEmotionKeyboardToolBar.h"
#import "LCRecentlyEmotionView.h"
#import "LCDefaultEmotionView.h"
#import "LCEmojiEmotionView.h"
#import "LCLxhEmotionView.h"
#import "LCEmotionModel.h"
#import "LCEmotionsTool.h"
@interface LCEmotionKeyboardView ()<LCEmotionKeyboardToolBarDelegate , UIScrollViewDelegate>
@property (nonatomic , strong) LCEmotionKeyboardToolBar *myToolBar;
@property (nonatomic , strong) UIScrollView *contentView;

@property (nonatomic , strong) LCRecentlyEmotionView *recentlyEmotionView;
@property (nonatomic , strong) LCDefaultEmotionView *defauleEmotionView;
@property (nonatomic , strong) LCEmojiEmotionView *emojiEmotionView;
@property (nonatomic ,strong) LCLxhEmotionView *lxhEmotionView;

@end
@implementation LCEmotionKeyboardView
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kLCEmotionKeyboardDidSelectedEmotiomNotification object:nil];
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pressEmotionsKeyboard) name:kLCEmotionKeyboardDidSelectedEmotiomNotification object:nil];
#warning _BSMachError: (os/kern) invalid capability (20)_BSMachError: (os/kern) invalid name (15) 消除这个警告 引起卡顿一下再弹出键盘
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setupAllEmotionView];
        });
    }
    return self;
}
#pragma mark --监听到选择表情的通知,刷新最近的表情
- (void)pressEmotionsKeyboard{
    _recentlyEmotionView.emmtionsModelArray = [LCEmotionsTool recentlyEmotions];
}
#pragma mark -- 懒加载
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc]init];
        [self addSubview:self.contentView];
        _contentView.showsHorizontalScrollIndicator= NO;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.pagingEnabled = YES;
        _contentView.delegate = self;
    }
    return _contentView;
}
- (void)setupAllEmotionView{
    [self recentlyEmotionView];
    [self defauleEmotionView];
    [self emojiEmotionView];
    [self lxhEmotionView];
}
- (LCRecentlyEmotionView *)recentlyEmotionView{
    if (!_recentlyEmotionView) {
        _recentlyEmotionView = [[LCRecentlyEmotionView alloc]init];
        _recentlyEmotionView.emmtionsModelArray = [LCEmotionsTool recentlyEmotions];
        [self.contentView addSubview:_recentlyEmotionView];
    }
    return _recentlyEmotionView;
}
- (LCDefaultEmotionView *)defauleEmotionView{
    if (!_defauleEmotionView) {
        _defauleEmotionView = [[LCDefaultEmotionView alloc]init];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"/EmotionIcons/default/info.plist" ofType:nil];
        _defauleEmotionView.emmtionsModelArray = [LCEmotionModel mj_objectArrayWithFile:path];
        [self.contentView addSubview:_defauleEmotionView];
    }
    return _defauleEmotionView;
}

- (LCEmojiEmotionView *)emojiEmotionView{
    if (!_emojiEmotionView) {
        _emojiEmotionView = [[LCEmojiEmotionView alloc]init];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"/EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiEmotionView.emmtionsModelArray = [LCEmotionModel mj_objectArrayWithFile:path];
        [self.contentView addSubview:_emojiEmotionView];
    }
    return _emojiEmotionView;
}

- (LCLxhEmotionView *)lxhEmotionView{
    if (!_lxhEmotionView) {
        _lxhEmotionView = [[LCLxhEmotionView alloc]init];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"/EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhEmotionView.emmtionsModelArray = [LCEmotionModel mj_objectArrayWithFile:path];
        [self.contentView addSubview:_lxhEmotionView];
    }
    return _lxhEmotionView;
}

- (LCEmotionKeyboardToolBar *)myToolBar{
    if (!_myToolBar) {
        _myToolBar = [[LCEmotionKeyboardToolBar alloc]init];
        _myToolBar.delegate = self;
        [self addSubview:_myToolBar];
    }
    return _myToolBar;
}

#pragma mark --LCEmotionKeyboardToolBarDelegate
-(void)emotionTabBar:(LCEmotionKeyboardToolBar *)tabBar didSelectButton:(LCEmotionKeyboardToolBarButtonType)buttonType{
//    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    switch (buttonType) {
        case LCEmotionKeyboardToolBarButtonTypeRecent:{
            self.contentView.contentOffset = CGPointMake(0, 0);
            [self.recentlyEmotionView reloadListEmotionsView];
//            [self.contentView addSubview:self.recentlyEmotionView];
            break;
        }
        case LCEmotionKeyboardToolBarButtonTypeDefault:{
           self.contentView.contentOffset = CGPointMake(self.contentView.width, 0);
            [self.defauleEmotionView reloadListEmotionsView];
//            [self.contentView addSubview:self.defauleEmotionView];
            break;
        }
        case LCEmotionKeyboardToolBarButtonTypeEmoji:{
           self.contentView.contentOffset = CGPointMake(self.contentView.width * 2, 0);
            [self.emojiEmotionView reloadListEmotionsView];
//            [self.contentView addSubview:self.emojiEmotionView];
            break;
        }
        case LCEmotionKeyboardToolBarButtonTypeLxh:{
            self.contentView.contentOffset = CGPointMake(self.contentView.width * 3, 0);
            [self.lxhEmotionView reloadListEmotionsView];
//            [self.contentView addSubview:self.lxhEmotionView];
            break;
        }
 
        default:
            break;
    }
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height - EmotiontToolbarH);
    self.myToolBar.frame = CGRectMake(0, self.size.height - EmotiontToolbarH, self.size.width, EmotiontToolbarH);
    
    for (int i = 0; i < self.contentView.subviews.count; i++) {
        UIView *myView = self.contentView.subviews[i];
        myView.x = self.contentView.width * i;
        myView.height = self.contentView.height;
        myView.y = 0;
        myView.width = self.contentView.width;
    }
    self.contentView.contentSize = CGSizeMake(self.width * 4, 0);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
     double pagenumber = scrollView.contentOffset.x / scrollView.width;
    if ( pagenumber < 1.0) {
        [self.myToolBar selectedBarButton:LCEmotionKeyboardToolBarButtonTypeRecent];
    }else if (pagenumber >= 1.0 && pagenumber < 2.0) {
        [self.myToolBar selectedBarButton:LCEmotionKeyboardToolBarButtonTypeDefault];
    }else if (pagenumber >= 2.0 && pagenumber < 3.0) {
        [self.myToolBar selectedBarButton:LCEmotionKeyboardToolBarButtonTypeEmoji];
    }else if (pagenumber >= 3.0 && pagenumber < 4.0) {
        [self.myToolBar selectedBarButton:LCEmotionKeyboardToolBarButtonTypeLxh];
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
