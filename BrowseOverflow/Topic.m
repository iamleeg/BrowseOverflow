//
//  Topic.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 17/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "Topic.h"


@implementation Topic
@synthesize name;
@synthesize tag;

- (id)initWithName:(NSString *)newName {
    if ((self = [super init])) {
        name = [newName copy];
    }
    return self;
}

- (id)initWithName:(NSString *)newName tag: (NSString *)newTag {
    if ((self = [super init])) {
        name = [newName copy];
        tag = [newTag copy];
    }
    return self;
}

- (void)dealloc {
    [name release];
    [tag release];
    [super dealloc];
}

@end
