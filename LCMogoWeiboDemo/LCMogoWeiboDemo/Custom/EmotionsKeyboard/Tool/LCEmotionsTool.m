//
//  LCEmotionsTool.m
//  LCMogoWeiboDemo
//
//  Created by 李策 on 16/5/11.
//  Copyright © 2016年 李策. All rights reserved.
//

#import "LCEmotionsTool.h"
#import "LCEmotionModel.h"

// 最近表情的存储路径
#define LCRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]
@implementation LCEmotionsTool
static NSMutableArray *_emotions;
/**
 * 在加载这个类的时候调用一次
 */
+ (void)initialize{
   _emotions = [NSKeyedUnarchiver unarchiveObjectWithFile:LCRecentEmotionsPath];
    if (_emotions == nil) {
        _emotions = [NSMutableArray array];
    }

}
+ (void)addRecentlyEmotinon:(LCEmotionModel *)emotion{
//    //删除相同的表情,需要重写
//    [_emotions removeObject:emotion];
    for (LCEmotionModel *model in _emotions) {
        if ([model isEqual:emotion]) {
            return;
        }
    }
    // 将表情放到数组的最前面
    [_emotions insertObject:emotion atIndex:0];
    if (_emotions.count > 20) {
       [_emotions removeObjectsInRange:NSMakeRange(20, _emotions.count - 20)];
    }
    // 将所有的表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:_emotions toFile:LCRecentEmotionsPath];
}
+ (NSMutableArray *)recentlyEmotions{
    return _emotions;
}
@end
