//
//  LCBigImageScrollView.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/9.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCBigImageScrollView;
@protocol LCBigImageScrollViewDelegate<NSObject>

- (void) tapImageViewTappedWithObject:(LCBigImageScrollView *) sender;


@end

@interface LCBigImageScrollView : UIScrollView
@property (nonatomic , weak)  id<LCBigImageScrollViewDelegate>BigImg_Delegate;
- (void) setContentWithFrame:(CGRect) rect;
- (void) setImage:(UIImage *) image;
- (void) setAnimationRect;
- (void) rechangeInitRdct;
@end
