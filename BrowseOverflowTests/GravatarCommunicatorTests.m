//
//  GravatarCommunicatorTests.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 26/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "GravatarCommunicatorTests.h"
#import "GravatarCommunicator.h"
#import "FakeGravatarDelegate.h"

@implementation GravatarCommunicatorTests

- (void)setUp {
    communicator = [[GravatarCommunicator alloc] init];
    delegate = [[FakeGravatarDelegate alloc] init];
    communicator.url = [NSURL URLWithString: @"http://example.com/avatar"];
    communicator.delegate = delegate;
    fakeData = [[@"Fake data" dataUsingEncoding: NSUTF8StringEncoding] retain];
}

- (void)tearDown {
    [delegate release];
    [communicator release];
    [fakeData release];
}

- (void)testThatCommunicatorPassesURLBackWhenCompleted {
    [communicator connectionDidFinishLoading: nil];
    STAssertEqualObjects([delegate reportedURL], communicator.url, @"The communicator needs to explain which URL it's downloaded content for");
}

- (void)testThatCommunicatorPassesDataWhenCompleted {
    communicator.receivedData = [[fakeData mutableCopy] autorelease];
    [communicator connectionDidFinishLoading: nil];
    STAssertEqualObjects([delegate reportedData], fakeData, @"The communicator needs to pass its data to the delegate");
}

- (void)testCommunicatorKeepsURLRequested {
    NSURL *differentURL = [NSURL URLWithString: @"http://example.org/notthesameURL"];
    [communicator fetchDataForURL: differentURL];
    STAssertEqualObjects(communicator.url, differentURL, @"Communicator holds on to URL");
}

- (void)testCommunicatorCreatesAURLConnection {
    [communicator fetchDataForURL: communicator.url];
    STAssertNotNil(communicator.connection, @"The communicator should create an NSURLConnection here");
}

- (void)testCommunicatorDiscardsDataWhenResponseReceived {
    communicator.receivedData = [[fakeData mutableCopy] autorelease];
    [communicator connection: nil didReceiveResponse: nil];
    STAssertEquals([communicator.receivedData length], (NSUInteger)0, @"Data should have been discarded");
}

@end
