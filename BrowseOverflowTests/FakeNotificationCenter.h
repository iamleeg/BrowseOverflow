//
//  FakeNotificationCenter.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 27/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FakeNotificationCenter : NSObject 

- (void)addObserver: (id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;
- (void)removeObserver: (id)observer;
- (void)postNotification: (NSNotification *)notification;
- (void)removeObserver: (id)observer name: (NSString *)aName object: (id)obj;
- (BOOL)hasObject: (id)observer forNotification: (NSString *)aName;
- (BOOL)didReceiveNotification: (NSString *)name fromObject: (id)obj;

@end
