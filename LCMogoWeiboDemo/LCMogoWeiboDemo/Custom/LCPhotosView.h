//
//  LCPhotosView.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/26.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCPhtotoImageView;

@protocol LCPhotosViewDelegate <NSObject>

- (void)tappedPhotosViewAtPhotoImageView:(LCPhtotoImageView *)photoImageView andCurrentImageIndex:(int)index andImagesArray:(NSArray *)imagesArray andImagesFrameArray:(NSArray *)imagesFrameArray;

@end

@interface LCPhotosView : UIView
@property (nonatomic , strong) NSArray *photosArray;
@property (nonatomic , weak) id<LCPhotosViewDelegate>delegate;
+ (CGSize)photosViewSizeWithCount:(int)count;
@end
