//
//  BrowseOverflowObjectConfiguration.h
//  BrowseOverflow
//
//  Created by Graham Lee on 01/11/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StackOverflowManager;
@class AvatarStore;

@interface BrowseOverflowObjectConfiguration : NSObject

/**
 * A fully configured StackOverflowManager instance.
 */
- (StackOverflowManager *)stackOverflowManager;

/**
 * A fully configured AvatarStore instance.
 */
- (AvatarStore *)avatarStore;

@end
