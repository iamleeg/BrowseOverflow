//
//  AvatarStore+TestingExtensions.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 26/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "AvatarStore+TestingExtensions.h"


@implementation AvatarStore (TestingExtensions)

- (void)setData:(NSData *)data forLocation:(NSString *)location {
    [dataCache setObject: data forKey: location];
}

- (NSUInteger)dataCacheSize {
    return [[dataCache allKeys] count];
}

@end
