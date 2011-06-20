//
//  FakeNotificationCenter.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 27/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "FakeNotificationCenter.h"


@implementation FakeNotificationCenter

- (id)init {
    self = [super init];
    if (self) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
    [dictionary release];
    [super dealloc];
}

- (void)addObserver: (id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject {
    [dictionary setObject: observer forKey: aName];
}

- (void)removeObserver:(id)observer {
    [[[dictionary copy] autorelease] enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        if ([obj isEqual: observer]) {
            [dictionary removeObjectForKey: key];
        }
    }];
}

- (BOOL)hasObject:(id)observer forNotification:(NSString *)aName {
    return [[dictionary objectForKey: aName] isEqual: observer];
}

@end
