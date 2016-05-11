//
//  LCStatusCell.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/4/25.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCTableViewCell.h"
#import "LCStatusFrameModel.h"
@class LCStatusCell;
@class LCPhtotoImageView;
@protocol LCStatusCellDelegate<NSObject>

- (void)statusCell:(LCStatusCell *)cell tappedPhotosViewAtPhotoImageView:(LCPhtotoImageView *)photoImageView andCurrentImageIndex:(int)index andImagesArray:(NSArray *)imagesArray andImagesFrameArray:(NSArray *)imgaesFrameArray;

@end

@interface LCStatusCell : LCTableViewCell
@property (nonatomic , weak) id<LCStatusCellDelegate>cell_delegate;
@property (nonatomic , strong) LCStatusFrameModel *frameModel;
@end
