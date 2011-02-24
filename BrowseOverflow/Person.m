//
//  Person.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 24/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "Person.h"


@implementation Person

@synthesize name;
@synthesize avatarURL;

- (id)initWithName:(NSString *)aName avatarLocation:(NSString *)location {
    if ((self = [super init])) {
        name = [aName copy];
        avatarURL = [[NSURL alloc] initWithString: location];
    }
    return self;
}

- (void)dealloc {
    [name release];
    [avatarURL release];
    [super dealloc];
}

@end
