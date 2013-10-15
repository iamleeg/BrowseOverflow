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
    fakeData = [@"Fake data" dataUsingEncoding: NSUTF8StringEncoding];
}

- (void)testThatCommunicatorPassesURLBackWhenCompleted {
    [communicator connectionDidFinishLoading: nil];
    XCTAssertEqualObjects([delegate reportedURL], communicator.url, @"The communicator needs to explain which URL it's downloaded content for");
}

- (void)testThatCommunicatorPassesDataWhenCompleted {
    communicator.receivedData = [fakeData mutableCopy];
    [communicator connectionDidFinishLoading: nil];
    XCTAssertEqualObjects([delegate reportedData], fakeData, @"The communicator needs to pass its data to the delegate");
}

- (void)testCommunicatorKeepsURLRequested {
    NSURL *differentURL = [NSURL URLWithString: @"http://example.org/notthesameURL"];
    [communicator fetchDataForURL: differentURL];
    XCTAssertEqualObjects(communicator.url, differentURL, @"Communicator holds on to URL");
}

- (void)testCommunicatorCreatesAURLConnection {
    [communicator fetchDataForURL: communicator.url];
    XCTAssertNotNil(communicator.connection, @"The communicator should create an NSURLConnection here");
}

- (void)testCommunicatorDiscardsDataWhenResponseReceived {
    communicator.receivedData = [fakeData mutableCopy];
    [communicator connection: nil didReceiveResponse: nil];
    XCTAssertEqual([communicator.receivedData length], (NSUInteger)0, @"Data should have been discarded");
}

- (void)testCommunicatorAppendsReceivedData {
    communicator.receivedData = [fakeData mutableCopy];
    NSData *extraData = [@" more" dataUsingEncoding: NSUTF8StringEncoding];
    NSData *expectedData = [@"Fake data more" dataUsingEncoding: NSUTF8StringEncoding];
    [communicator connection: nil didReceiveData: extraData];
    XCTAssertEqualObjects([communicator.receivedData copy], expectedData, @"Should append data when it gets received");
}

- (void)testURLPassedBackOnError {
    [communicator connection: nil didFailWithError: nil];
    XCTAssertEqualObjects([delegate reportedURL], communicator.url, @"delegate knows which URL got an error");
}

@end
