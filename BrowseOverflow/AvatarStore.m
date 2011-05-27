//
//  AvatarStore.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 26/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "AvatarStore.h"


@implementation AvatarStore

- (id)init {
    self = [super init];
    if (self) {
        dataCache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
    [dataCache release];
    [super dealloc];
}

- (NSData *)dataForURL:(NSURL *)url {
    return [dataCache objectForKey: [url absoluteString]];
}

- (void)didReceiveMemoryWarning {
    [dataCache removeAllObjects];
}

@end
