//
//  UIScrollView+LCRefresh.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/20.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "UIScrollView+LCRefresh.h"
#import <ImageIO/ImageIO.h>
#import "UIImage+GIF.h"
@implementation UIScrollView (LCRefresh)
- (void)addRefreshHeader:(void(^)())headerRefreshBlock{
    
    __weak UIScrollView *weakSelf = self;
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //执行block
        if(headerRefreshBlock){
            headerRefreshBlock();
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.mj_header endRefreshing];
        });
    }];
    UIImage *images = [UIImage sd_animatedGIFNamed:@"jhLoading"];
    [header setImages:@[images] forState:MJRefreshStatePulling];
    header.automaticallyChangeAlpha = YES;
    
    self.mj_header = header;
}

- (void)removeRefreshHeader{
    [self.mj_header endRefreshing];
    self.mj_header = nil;
}



- (void)addRefreshFooter:(void(^)())footerRefreshBlock{
    
    __weak UIScrollView *weakSelf = self;
       MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        //执行block
        if(footerRefreshBlock){
            footerRefreshBlock();
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.mj_footer endRefreshing];
        });
    }];
    UIImage *images = [UIImage sd_animatedGIFNamed:@"hardLoding"];
    [footer setImages:@[images] forState:MJRefreshStatePulling];
    self.mj_footer = footer;
}
- (void)removeRefreshFooter{
    [self.mj_footer endRefreshing];
    self.mj_footer = nil;
}

//--->runtime

static char imagesKey;

- (void)setImages:(NSArray *)images{
    objc_setAssociatedObject(self, &imagesKey, images, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)getImages:(NSString *)gifImageName{
    if(objc_getAssociatedObject(self, &imagesKey)==nil){
        
        NSArray *images = [self returnImagesWithGifName:gifImageName];
        objc_setAssociatedObject(self, &imagesKey, images, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, &imagesKey);
}
//返回gif名 3x还是 2x
- (NSString *)gifHeaderName{
    
    CGFloat scale = [UIScreen mainScreen].scale;
    if(scale == 2){
        return @"jhLoading@2x.gif";
    }else if(scale == 3){
        return @"jhLoading@3x.gif";
    }
    return @"jhLoading@2x.gif";
}

//返回gif名 3x还是 2x
- (NSString *)gifFooterName{
    
    CGFloat scale = [UIScreen mainScreen].scale;
    if(scale == 2){
        return @"hardLoding@2x.gif";
    }else if(scale == 3){
        return @"hardLoding@3x.gif";
    }
    return @"hardLoding@2x.gif";
}

//这种方式是直接返回一个UIImage对象的数组
- (NSArray *)returnImagesWithGifName:(NSString *)gif{
    
    NSString *gifPath = [[NSBundle mainBundle] pathForResource:gif ofType:nil];
    
    NSData *gifData = [NSData dataWithContentsOfFile:gifPath];
    
    CFDataRef dataRef = (__bridge CFDataRef)(gifData);
    
    CGImageSourceRef source = CGImageSourceCreateWithData(dataRef, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    NSMutableArray *images = [NSMutableArray array];
    
    if(count<=1){
        
        UIImage *image = [UIImage imageWithData:gifData];
        [images addObject:image];
        
        CFRelease(source);
        
        return images;
        
    }else{
        
        for (size_t i=0; i<count; i++) {
            
            CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            UIImage *image = [UIImage imageWithCGImage:imageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
            
            [images addObject:image];
            
            CGImageRelease(imageRef);
            CGImageSourceRemoveCacheAtIndex(source, i);
        }
        
        CFRelease(source);
        
        return images;
    }
}


@end
