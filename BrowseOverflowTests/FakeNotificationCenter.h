//
//  FakeNotificationCenter.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 27/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FakeNotificationCenter : NSObject {
    NSMutableDictionary *dictionary;
}

- (void)addObserver: (id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;
- (void)removeObserver: (id)observer;
- (BOOL)hasObject: (id)observer forNotification: (NSString *)aName;

@end
