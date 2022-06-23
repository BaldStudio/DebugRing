//
//  DebugCrashPlugin.m
//  DebugRing
//
//  Created by crzorz on 2022/6/23.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

#import "DebugCrashPlugin.h"
#import <DebugRing/DebugRing-Swift.h>
#import "DebugRingDefines.h"
#import "DebugCrashViewController.h"

debug_ring_interface(DebugCrashPlugin) ()<DebugPluginRepresentable>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) UIImage *icon;

@end

@implementation DebugCrashPlugin

- (instancetype)init {
    self = [super init];
    if (self) {
        _name = @"模拟Crash";
        _icon = [UIImage systemImageNamed:@"circle"];
    }
    return self;
}

- (void)onDidSelect {
    [DebugController push:[DebugCrashViewController new]];
}

@end
