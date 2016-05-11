//
//  LCPhtotoImageView.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/26.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCPicModel;
@class LCPhtotoImageView;
@protocol LCPhtotoImageViewDelegate <NSObject>

- (void)tappedPhotoImageView:(LCPhtotoImageView *)photoImageView;

@end

@interface LCPhtotoImageView : UIImageView
@property (nonatomic , strong) id<LCPhtotoImageViewDelegate>delegate;
@property (nonatomic , strong) LCPicModel *picModel;
@property (nonatomic , assign) int indexTag;
@end
