//
//  DebugRingDefines.h
//  DebugRing
//
//  Created by crzorz on 2022/6/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

#ifndef DebugRingDefines_h
#define DebugRingDefines_h

#import <Foundation/Foundation.h>

//MARK: - bootstrap

@protocol DebueRingLoadAutomatable <NSObject>
+ (void)objcLoad;
@end

#define DebugRingBootstrap(className) \
@interface className (DebueRingLoadAutomatable) \
@end \
@implementation className (DebueRingLoadAutomatable) \
+ (void)load { [self.class objcLoad]; } \
@end


//MARK: - MachO

#define DEBUG_RING_SEG     "__DEBUG_RING"
#define DEBUG_RING_SECT    "__plugin"

struct DebugRingPluginData {
    char *name;
};
typedef struct DebugRingPluginData DebugRingPluginData;

#define debug_ring_interface(name) \
debug_ring_plugin_annotation(name); \
@interface name

#define debug_ring_plugin_annotation(_name_) \
__attribute((used, section(DEBUG_RING_SEG "," DEBUG_RING_SECT))) \
static const DebugRingPluginData __debug_ring_##_name_##_plugin = \
{ \
    .name = #_name_, \
}


#endif /* DebugRingDefines_h */
