//
//  CatchCrash.h
//  WiFi
//
//  Created by MoGo on 15/12/31.
//  Copyright © 2015年 MoGo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatchCrash : NSObject
void uncaughtExceptionHandler(NSException *exception);

@end
