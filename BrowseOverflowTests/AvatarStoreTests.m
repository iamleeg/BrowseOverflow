//
//  AvatarStoreTests.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 26/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "AvatarStoreTests.h"
#import "AvatarStore.h"
#import "AvatarStore+TestingExtensions.h"
#import "FakeNotificationCenter.h"

@implementation AvatarStoreTests

- (void)setUp {
    center = [[FakeNotificationCenter alloc] init];
    store = [[AvatarStore alloc] init];
    sampleData = [[@"sample data" dataUsingEncoding: NSUTF8StringEncoding] retain];
    sampleLocation = @"http://example.com/avatar/sample";
    [store setData: sampleData forLocation: sampleLocation];
    otherLocation = @"http://example.com/avatar/other";
}

- (void)tearDown {
    [center release];
    [store release];
    [sampleData release];
}

- (void)testLookupDataInCacheDictionary {
    NSData *retrievedData = [store dataForURL: [NSURL URLWithString: sampleLocation]];
    STAssertEqualObjects(retrievedData, sampleData, @"If the data's already in the dictionary ");
}

- (void)testLowMemoryWarningRemovesCache {
    [store didReceiveMemoryWarning: nil];
    STAssertEquals([store dataCacheSize], (NSUInteger)0, @"Cache should be purged");
}

- (void)testStoreSubscribesToLowMemoryNotification {
    [store registerForMemoryWarnings: (NSNotificationCenter *)center];
    STAssertTrue([center hasObject: store forNotification: UIApplicationDidReceiveMemoryWarningNotification], @"store should have registered for the notification");
}

- (void)testStoreRemovesSubscriptionFromLowMemoryNotification {
    [store registerForMemoryWarnings: (NSNotificationCenter *)center];
    [store removeRegistrationForMemoryWarnings: (NSNotificationCenter *)center];
    STAssertFalse([center hasObject: store forNotification: UIApplicationDidReceiveMemoryWarningNotification], @"Object should no longer be registered for low memory warnings");
}

- (void)testCacheMissReturnsNoData {
    STAssertNil([store dataForURL: [NSURL URLWithString: otherLocation]], @"There shouldn't be any data for this location");
}

- (void)testCacheMissCreatesNewCommunicator {
    [store dataForURL: [NSURL URLWithString: otherLocation]];
    STAssertNotNil([[store communicators] objectForKey: otherLocation], @"Store tries to fetch data from the network");
}

@end
