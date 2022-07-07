//
//  DebueRingLoadAutomatable.m
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

#import "DebueRingLoadAutomatable.h"
#import <DebugRing/DebugRing-Swift.h>

@interface DebugRingLoader (DebueRingLoadAutomatable)

@end

@implementation DebugRingLoader (DebueRingLoadAutomatable)

+ (void)load {
    [self.class objcLoad];
}

@end
