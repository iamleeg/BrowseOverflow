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
    receivedData = [@"Result" dataUsingEncoding: NSUTF8StringEncoding];
}

- (void)tearDown {
    [communicator cancelAndDiscardURLConnection];
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

- (void)testConnectionFailingPassesErrorToDelegate {
    [nnCommunicator searchForQuestionsWithTag: @"ios"];
    NSError *error = [NSError errorWithDomain: @"Fake domain" code: 12345 userInfo: nil];
    [nnCommunicator connection: nil didFailWithError: error];
    STAssertEquals([manager topicFailureErrorCode], 12345, @"Failure to connect should get passed to the delegate");
}

- (void)testSuccessfulQuestionSearchPassesDataToDelegate {
    [nnCommunicator searchForQuestionsWithTag: @"ios"];
    [nnCommunicator setReceivedData: receivedData];
    [nnCommunicator connectionDidFinishLoading: nil];
    STAssertEqualObjects([manager topicSearchString], @"Result", @"The delegate should have received data on success");
}

- (void)testSuccessfulBodyFetchPassesDataToDelegate {
    [nnCommunicator downloadInformationForQuestionWithID: 12345];
    [nnCommunicator setReceivedData: receivedData];
    [nnCommunicator connectionDidFinishLoading: nil];
    STAssertEqualObjects([manager questionBodyString], @"Result", @"The delegate should have received the question body data");
}

- (void)testSuccessfulAnswerFetchPassesDataToDelegate {
    [nnCommunicator downloadAnswersToQuestionWithID: 12345];
    [nnCommunicator setReceivedData: receivedData];
    [nnCommunicator connectionDidFinishLoading: nil];
    STAssertEqualObjects([manager answerListString], @"Result", @"Answer list should be passed to delegate");
}

- (void)testAdditionalDataAppendedToDownload {
    [nnCommunicator setReceivedData: receivedData];
    NSData *extraData = [@" appended" dataUsingEncoding: NSUTF8StringEncoding];
    [nnCommunicator connection: nil didReceiveData: extraData];
    NSString *combinedString = [[NSString alloc] initWithData: [nnCommunicator receivedData] encoding: NSUTF8StringEncoding];
    STAssertEqualObjects(combinedString, @"Result appended", @"Received data should be appended to the downloaded data");
}

@end
