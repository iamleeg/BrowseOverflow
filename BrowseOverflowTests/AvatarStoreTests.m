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

- (void)testLookupDataInCacheDictionary {
    AvatarStore *store = [[AvatarStore alloc] init];
    NSData *sampleData = [@"sample data" dataUsingEncoding: NSUTF8StringEncoding];
    NSString *sampleLocation = @"http://example.com/avatar/sample";
    [store setData: sampleData forLocation: sampleLocation];
    NSData *retrievedData = [store dataForURL: [NSURL URLWithString: sampleLocation]];
    STAssertEqualObjects(retrievedData, sampleData, @"If the data's already in the dictionary ");
    [store release];
}

@end
