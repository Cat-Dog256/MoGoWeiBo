//
//  LCListEmotionView.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/29.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCListEmotionView.h"
#import "LCEmotionModel.h"
#import "LCEmotionsPageView.h"
#import "LCEmotionsConst.h"
@interface LCListEmotionView ()<UIScrollViewDelegate>
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , strong) UIPageControl *pageControl;
@end

@implementation LCListEmotionView
- (instancetype)init{
    if (self = [super init]) {

        _scrollView = [[UIScrollView alloc]init];
        [self addSubview:_scrollView];
        _scrollView.backgroundColor = kBgWhiteColor;
        _scrollView.showsHorizontalScrollIndicator= NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;

        
        _pageControl = [[UIPageControl alloc]init];
        /**
         *  当只有一页的时候隐藏
         */
        _pageControl.hidesForSinglePage = YES;
        _pageControl.userInteractionEnabled = NO;
        _pageControl.backgroundColor = kBgWhiteColor;
        // 设置内部的圆点图片
        [_pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [_pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        [self addSubview:_pageControl];
    }
    return self;
}
- (void)setEmmtionsModelArray:(NSArray *)emmtionsModelArray{
    _emmtionsModelArray = emmtionsModelArray;
    //删除之之前的表情
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.pageControl.numberOfPages = (emmtionsModelArray.count + EmotionsPageCout - 1) / EmotionsPageCout;
    for (int i = 0; i < self.pageControl.numberOfPages; i++) {
        LCEmotionsPageView *pageView = [[LCEmotionsPageView alloc]init];
        NSRange range;
        range.location = i * EmotionsPageCout;
        NSUInteger leftCount = emmtionsModelArray.count - EmotionsPageCout * i;
        if (leftCount >= EmotionsPageCout) {
            range.length = EmotionsPageCout;
        }else{
            range.length = leftCount;
        }
        
        pageView.pageEmotionsArray = [emmtionsModelArray subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
    /**
     *  重新排布按钮
     */
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.pageControl.frame = CGRectMake(0, self.height - PageControlH, SCREEN_WIDTH, PageControlH);
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.pageControl.y);
    
    CGFloat viewX = 0;
    CGFloat viewY = 0;
    CGFloat viewW = SCREEN_WIDTH;
    CGFloat viewH = self.scrollView.size.height;

    for (int i = 0; i < self.scrollView.subviews.count; i++) {
        UIView *myView = self.scrollView.subviews[i];
        myView.x = viewX + viewW * i;
        myView.y = viewY;
        myView.width = viewW;
        myView.height = viewH;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * self.pageControl.numberOfPages, self.scrollView.height);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double pagenumber = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = pagenumber + 0.5;
}
#pragma mark --self.scrollView偏移量设置为零
- (void)reloadListEmotionsView{
    self.scrollView.contentOffset = CGPointMake(0, 0);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
