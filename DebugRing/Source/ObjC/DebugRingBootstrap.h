//
//  DebugRingBootstrap.h
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

#ifndef DebugRingBootstrap_h
#define DebugRingBootstrap_h

#import <Foundation/Foundation.h>

@protocol DebueRingLoadAutomatable <NSObject>
+ (void)objcLoad;
@end

#define DebugRingBootstrap(className) \
@interface className (DebueRingLoadAutomatable) \
@end \
@implementation className (DebueRingLoadAutomatable) \
+ (void)load { [self.class objcLoad]; } \
@end

#endif /* DebugRingBootstrap_h */
