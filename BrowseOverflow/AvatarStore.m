//
//  AvatarStore.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 26/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "AvatarStore.h"
#import "GravatarCommunicator.h"

@implementation AvatarStore

- (id)init {
    self = [super init];
    if (self) {
        dataCache = [[NSMutableDictionary alloc] init];
        communicators = [[NSMutableDictionary alloc] init];
    }
    return self;
}


- (NSData *)dataForURL:(NSURL *)url {
    if (url == nil) {
        return nil;
    }
    NSData *avatarData = [dataCache objectForKey: [url absoluteString]];
    if (!avatarData) {
        GravatarCommunicator *communicator = [[GravatarCommunicator alloc] init];
        [communicators setObject: communicator forKey: [url absoluteString]];
        communicator.delegate = self;
        [communicator fetchDataForURL: url];
    }
    return avatarData;
}

- (void)didReceiveMemoryWarning: (NSNotification *)note {
    [dataCache removeAllObjects];
}

- (void)useNotificationCenter:(NSNotificationCenter *)center {
    [center addObserver: self selector: @selector(didReceiveMemoryWarning:) name: UIApplicationDidReceiveMemoryWarningNotification object: nil];
    notificationCenter = center;
}

- (void)stopUsingNotificationCenter:(NSNotificationCenter *)center {
    [center removeObserver: self];
    notificationCenter = nil;
}

- (void)communicatorGotErrorForURL:(NSURL *)url {
    [communicators removeObjectForKey: [url absoluteString]];
}

- (void)communicatorReceivedData:(NSData *)data forURL:(NSURL *)url {
    [dataCache setObject: data forKey: [url absoluteString]];
    [communicators removeObjectForKey: [url absoluteString]];
    NSNotification *note = [NSNotification notificationWithName: AvatarStoreDidUpdateContentNotification object: self];
    [notificationCenter postNotification: note];
}

@end

NSString *AvatarStoreDidUpdateContentNotification = @"AvatarStoreDidUpdateContentNotification";