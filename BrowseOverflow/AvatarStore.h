//
//  AvatarStore.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 26/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GravatarCommunicatorDelegate.h"

@interface AvatarStore : NSObject <GravatarCommunicatorDelegate> {
    NSMutableDictionary *dataCache;
    NSMutableDictionary *communicators;
}

- (NSData *)dataForURL: (NSURL *)url;
- (void)didReceiveMemoryWarning: (NSNotification *)note;
- (void)registerForMemoryWarnings: (NSNotificationCenter *)center;
- (void)removeRegistrationForMemoryWarnings: (NSNotificationCenter *)center;
@end

extern NSString *AvatarStoreDidUpdateContentNotification;
