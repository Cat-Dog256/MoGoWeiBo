//
//  LCPhotosView.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/26.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCPhotosView.h"
#define PHOTO_SIZE ([UIScreen mainScreen].bounds.size.width - 40)/3
#define PHOTO_SPACE 10
#define MAX_COL(count) (count == 4 ? 2 :3)
#import "LCPicModel.h"
#import "LCPhtotoImageView.h"
#import "UIImageView+WebCache.h"

@interface LCPhotosView ()<LCPhtotoImageViewDelegate>
@property(nonatomic , strong) NSMutableArray *imageArray;
@property(nonatomic , strong) NSMutableArray *imageFrameArray;
@end

@implementation LCPhotosView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
- (NSMutableArray *)imageFrameArray{
    if (!_imageFrameArray) {
        _imageFrameArray = [NSMutableArray array];
    }
    return _imageFrameArray;
}
- (void)setPhotosArray:(NSArray *)photosArray{
    [self.imageArray removeAllObjects];
    _photosArray = photosArray;
        while (self.subviews.count < photosArray.count) {
        LCPhtotoImageView *imageView = [[LCPhtotoImageView alloc]init];
            imageView.delegate = self;
        [self addSubview:imageView];
    }
    
    //设置图片
    
    for (int i = 0; i < self.subviews.count; i++) {
        LCPhtotoImageView *imageV = self.subviews[i];
        //便利所有的子视图，如果i<photosArray.count显示图片，否则隐藏
        if (i < photosArray.count) {
            imageV.hidden = NO;
            imageV.indexTag = i;
            imageV.picModel = photosArray[i];
            NSString *picUrl = [imageV.picModel thumbnail_pic];

            [imageV sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [self.imageArray addObject:image];
            }];

        }else{
            imageV.hidden = YES;
        }
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imageFrameArray removeAllObjects];
    for (int i = 0 ; i < self.photosArray.count; i++) {
        LCPhtotoImageView *imageV = self.subviews[i];
        int maxCol = MAX_COL(self.photosArray.count);
        int col = i % maxCol;
        int row = i / maxCol;
        CGFloat imageV_X = col * (PHOTO_SIZE + PHOTO_SPACE);
        CGFloat imageV_Y = row * (PHOTO_SIZE + PHOTO_SPACE);
        CGFloat imageV_W = PHOTO_SIZE;
        CGFloat imageV_H = PHOTO_SIZE;
        
        imageV.frame = CGRectMake(imageV_X, imageV_Y, imageV_W, imageV_H);
        [self.imageFrameArray addObject:imageV];
    }
}
#pragma mark**计算配图尺寸**

+ (CGSize)photosViewSizeWithCount:(int)count{
    int maxCol = MAX_COL(count);
    
    //列数
    int cols = (count >= maxCol) ? maxCol : count;
    
    //行数
    //    int rows = 0;
    //    if (count % 3 == 0) {
    //        rows = count % 3;
    //    }else{
    //        rows = count % 3 + 1;
    //    }
    int rows = (count + maxCol - 1) / maxCol;
    
    CGFloat width = cols * PHOTO_SIZE + (cols - 1) * PHOTO_SPACE;
    CGFloat height = rows * PHOTO_SIZE + (rows - 1) *PHOTO_SPACE;
    return CGSizeMake(width, height);
}

- (void)tappedPhotoImageView:(LCPhtotoImageView *)photoImageView{
    
    if ([self.delegate respondsToSelector:@selector(tappedPhotosViewAtPhotoImageView:andCurrentImageIndex:andImagesArray:andImagesFrameArray:)]) {
        [self.delegate tappedPhotosViewAtPhotoImageView:photoImageView andCurrentImageIndex:photoImageView.indexTag andImagesArray:self.imageArray andImagesFrameArray:self.imageFrameArray];
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
