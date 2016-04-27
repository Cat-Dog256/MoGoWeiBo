//
//  LCPhotosView.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/26.
//  Copyright © 2016年 李策. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCPhotosView : UIView
@property (nonatomic , strong) NSArray *photosArray;
+ (CGSize)photosViewSizeWithCount:(int)count;
@end
