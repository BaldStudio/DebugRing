//
//  DebugRingLoader.m
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

#import "DebugRingLoader.h"

@implementation DebugRingLoader

// 占坑，方便clazz调用
+ (void)objcLoad {}

+ (void)load {
    Class clazz = NSClassFromString(@"DebugRing.DebugController");
    if (clazz == NULL) { return; }
    [clazz objcLoad];
}

@end
