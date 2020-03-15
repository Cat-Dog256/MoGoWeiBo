//
//  TestViewController.h
//  LCMogoWeiboDemo
//
//  Created by 李策 on 2020/3/12.
//  Copyright © 2020 李策. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^popVcBlock) (UIColor *color);

@protocol TestVcDeletate <NSObject>

- (void)popVc:(UIColor *)color;

@end


@interface TestViewController : UIViewController

@property (nonatomic, weak) id<TestVcDeletate> delegate;
@property (nonatomic, copy) popVcBlock popBlock;

@end

NS_ASSUME_NONNULL_END
