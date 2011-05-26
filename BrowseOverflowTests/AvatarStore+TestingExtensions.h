//
//  AvatarStore+TestingExtensions.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 26/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AvatarStore.h"

@interface AvatarStore (TestingExtensions)

- (void)setData: (NSData *)data forLocation: (NSString *)location;

@end
