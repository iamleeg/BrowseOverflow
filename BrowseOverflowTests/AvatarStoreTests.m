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

@implementation AvatarStoreTests

- (void)setUp {
    store = [[AvatarStore alloc] init];
    sampleData = [[@"sample data" dataUsingEncoding: NSUTF8StringEncoding] retain];
    sampleLocation = @"http://example.com/avatar/sample";
    [store setData: sampleData forLocation: sampleLocation];
}

- (void)tearDown {
    [store release];
    [sampleData release];
}

- (void)testLookupDataInCacheDictionary {
    NSData *retrievedData = [store dataForURL: [NSURL URLWithString: sampleLocation]];
    STAssertEqualObjects(retrievedData, sampleData, @"If the data's already in the dictionary ");
}

- (void)testLowMemoryWarningRemovesCache {
    [store didReceiveMemoryWarning];
    STAssertEquals([store dataCacheSize], (NSUInteger)0, @"Cache should be purged");
}
@end
