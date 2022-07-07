//
//  DebugRingAnnotation.h
//  DebugRing
//
//  Created by crzorz on 2022/7/7.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

#ifndef DebugRingAnnotation_h
#define DebugRingAnnotation_h

struct DebugRingPluginData {
    char *name;
};
typedef struct DebugRingPluginData DebugRingPluginData;

#define DEBUG_RING_SEG     "__DEBUG_RING"
#define DEBUG_RING_SECT    "__plugin"

#define debug_ring_interface(name) \
debug_ring_plugin_annotation(name); \
@interface name

#define debug_ring_plugin_annotation(_name_) \
__attribute((used, section(DEBUG_RING_SEG "," DEBUG_RING_SECT))) \
static const DebugRingPluginData __debug_ring_##_name_##_plugin = { \
    .name = #_name_, \
}

#endif /* DebugRingAnnotation_h */
