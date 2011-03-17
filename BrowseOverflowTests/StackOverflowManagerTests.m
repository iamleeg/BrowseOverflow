//
//  StackOverflowManagerTests.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 14/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "StackOverflowManagerTests.h"
#import "StackOverflowManager.h"
#import "MockStackOverflowManagerDelegate.h"
#import "MockStackOverflowCommunicator.h"
#import "Topic.h"

@implementation StackOverflowManagerTests

- (void)setUp {
    mgr = [[StackOverflowManager alloc] init];
}

- (void)tearDown {
    [mgr release];
}

- (void)testNonConformingObjectCannotBeDelegate {
    STAssertThrows(mgr.delegate = [NSNull null], @"NSNull doesn't conform to the delegate protocol");
}

- (void)testConformingObjectCanBeDelegate {
    id <StackOverflowManagerDelegate> delegate = [[MockStackOverflowManagerDelegate alloc] init];
    STAssertNoThrow(mgr.delegate = delegate, @"Object conforming to the delegate protocol can be delegate");
    [delegate release];
}

- (void)testAskingForQuestionsMeansRequestingData {
    MockStackOverflowCommunicator *communicator = [[MockStackOverflowCommunicator alloc] init];
    mgr.communicator = communicator;
    Topic *topic = [[Topic alloc] initWithName: @"iPhone" tag: @"iphone"];
    [mgr fetchQuestionsOnTopic: topic];
    STAssertTrue([communicator wasAskedToFetchQuestions], @"The communicator should need to fetch data.");
    [topic release];
    [communicator release];
}

@end
