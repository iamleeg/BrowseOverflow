//
//  StackOverflowCommunicatorTests.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 11/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "StackOverflowCommunicatorTests.h"
#import "InspectableStackOverflowCommunicator.h"

@implementation StackOverflowCommunicatorTests

- (void)testSearchingForQuestionsOnTopicCallsTopicAPI {
    InspectableStackOverflowCommunicator *communicator = [[InspectableStackOverflowCommunicator alloc] init];
    [communicator searchForQuestionsWithTag: @"ios"];
    STAssertEqualObjects([[communicator URLToFetch] absoluteString], @"http://api.stackoverflow.com/1.1/search?tagged=ios&pagesize=20", @"Use the search API to find questions with a particular tag");
    [communicator release];
}

@end
