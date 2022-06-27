//
//  DebugCrashMocker.h
//  DebugRing
//
//  Created by crzorz on 2022/6/23.
//  Copyright © 2022 BaldStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DebugCrashMocker : NSObject

@property (nonatomic, readonly) NSArray<NSArray<NSString *> *> *caseData;

@end

NS_ASSUME_NONNULL_END
