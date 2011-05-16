//
//  StackOverflowCommunicatorTests.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 11/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "StackOverflowCommunicatorTests.h"
#import "InspectableStackOverflowCommunicator.h"
#import "NonNetworkedStackOverflowCommunicator.h"
#import "MockStackOverflowManager.h"
#import "FakeURLResponse.h"

@implementation StackOverflowCommunicatorTests

- (void)setUp {
    communicator = [[InspectableStackOverflowCommunicator alloc] init];
    nnCommunicator = [[NonNetworkedStackOverflowCommunicator alloc] init];
    manager = [[MockStackOverflowManager alloc] init];
    nnCommunicator.delegate = manager;
    fourOhFourResponse = [[FakeURLResponse alloc] initWithStatusCode: 404];
}

- (void)tearDown {
    [communicator cancelAndDiscardURLConnection];
    [communicator release];
    [nnCommunicator release];
    [manager release];
    [fourOhFourResponse release];
}

- (void)testSearchingForQuestionsOnTopicCallsTopicAPI {
    [communicator searchForQuestionsWithTag: @"ios"];
    STAssertEqualObjects([[communicator URLToFetch] absoluteString], @"http://api.stackoverflow.com/1.1/search?tagged=ios&pagesize=20", @"Use the search API to find questions with a particular tag");
}

- (void)testFillingInQuestionBodyCallsQuestionAPI {
    [communicator downloadInformationForQuestionWithID: 12345];
    STAssertEqualObjects([[communicator URLToFetch] absoluteString], @"http://api.stackoverflow.com/1.1/questions/12345?body=true", @"Use the question API to get the body for a question");
}

- (void)testFetchingAnswersToQuestionCallsQuestionAPI {
    [communicator downloadAnswersToQuestionWithID: 12345];
    STAssertEqualObjects([[communicator URLToFetch] absoluteString], @"http://api.stackoverflow.com/1.1/questions/12345/answers?body=true", @"Use the question API to get answers on a given question");
}

- (void)testSearchingForQuestionsCreatesURLConnection {
    [communicator searchForQuestionsWithTag: @"ios"];
    STAssertNotNil([communicator currentURLConnection], @"There should be a URL connection in-flight now.");
}

- (void)testStartingNewSearchThrowsOutOldConnection {
    [communicator searchForQuestionsWithTag: @"ios"];
    NSURLConnection *firstConnection = [communicator currentURLConnection];
    [communicator searchForQuestionsWithTag: @"cocoa"];
    STAssertFalse([[communicator currentURLConnection] isEqual: firstConnection], @"The communicator needs to replace its URL connection to start a new one");
}

- (void)testReceivingResponseDiscardsExistingData {
    nnCommunicator.receivedData = [@"Hello" dataUsingEncoding: NSUTF8StringEncoding];
    [nnCommunicator searchForQuestionsWithTag: @"ios"];
    [nnCommunicator connection: nil didReceiveResponse: nil];
    STAssertEquals([nnCommunicator.receivedData length], (NSUInteger)0, @"Data should have been discarded");
}

- (void)testReceivingResponseWith404StatusPassesErrorToDelegate {
    [nnCommunicator searchForQuestionsWithTag: @"ios"];
    [nnCommunicator connection: nil didReceiveResponse: (NSURLResponse *)fourOhFourResponse];
    STAssertEquals([manager topicFailureErrorCode], 404, @"Fetch failure was passed through to delegate");
}

- (void)testNoErrorReceivedOn200Status {
    FakeURLResponse *twoHundredResponse = [[FakeURLResponse alloc] initWithStatusCode: 200];
    [nnCommunicator searchForQuestionsWithTag: @"ios"];
    [nnCommunicator connection: nil didReceiveResponse: (NSURLResponse *)twoHundredResponse];
    [twoHundredResponse release];
    STAssertFalse([manager topicFailureErrorCode] == 200, @"No need for error on 200 response");
}
- (void)testReceiving404ResponseToQuestionBodyRequestPassesErrorToDelegate {
    [nnCommunicator downloadInformationForQuestionWithID: 12345];
    [nnCommunicator connection: nil didReceiveResponse: (NSURLResponse *)fourOhFourResponse];
    STAssertEquals([manager bodyFailureErrorCode], 404, @"Body fetch error was passed through to delegate");
}

- (void)testReceiving404ResponseToAnswerRequestPassesErrorToDelegate {
    [nnCommunicator downloadAnswersToQuestionWithID: 12345];
    [nnCommunicator connection: nil didReceiveResponse: (NSURLResponse *)fourOhFourResponse];
    STAssertEquals([manager answerFailureErrorCode], 404, @"Answer fetch error was passed to delegate");
}
@end
