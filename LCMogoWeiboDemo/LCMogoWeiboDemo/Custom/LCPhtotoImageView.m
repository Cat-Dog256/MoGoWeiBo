//
//  LCPhtotoImageView.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/26.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCPhtotoImageView.h"
#import "LCPicModel.h"
#import "UIImageView+WebCache.h"

@interface LCPhtotoImageView ()

@property (nonatomic , weak) UIImage *GIFImage;
@property (nonatomic , weak) UIImageView *gifView;
@end
@implementation LCPhtotoImageView
- (UIImageView *)gifView{
    if (_gifView == nil) {
        UIImage *GIFImage = [UIImage imageNamed:@"timeline_image_gif"];
        self.GIFImage = GIFImage;
        UIImageView *gifView = [[UIImageView alloc]init];
        gifView.image = GIFImage;
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return _gifView;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        /**
         *  UIViewContentModeScaleAspectFit, 这个图片都会在view里面显示，并且比例不变 这就是说 如果图片和view的比例不一样 就会有留白
            UIViewContentModeScaleAspectFill, 这是整个view会被图片填满，图片比例不变 ，这样图片显示就会大于view
         */
        /**
         *  UIViewContentModeScaleToFill：图片拉伸至填充这个UIImageView(图片可能变形)
         UIViewContentModeScaleAspectFit : 图片拉伸至完全显示在UIImageView里面为止（图片不会变形）
         UIViewContentModeScaleAspectFill ： 图片拉伸至 图片的宽度等于UIImageView的宽度 或者 图片的高度等于UIImageView的高度为止，然后将图片居中显示
         UIViewContentModeRedraw ： 调用了setNeedsDisplay方法时，就会将图片重新渲染
         UIViewContentModeCenter：居中显示
         */
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    UIImageView *imageV = [self.subviews lastObject];
    imageV.frame = CGRectMake(self.frame.size.width - self.GIFImage.size.width, self.frame.size.height - self.GIFImage.size.height, self.GIFImage.size.width, self.GIFImage.size.height);
}

- (void)setPicModel:(LCPicModel *)picModel{
    _picModel = picModel;
    NSString *picUrl = [picModel thumbnail_pic];
    [self sd_setImageWithURL:[NSURL URLWithString:picUrl]  placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    if ([picUrl.lowercaseString hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
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
