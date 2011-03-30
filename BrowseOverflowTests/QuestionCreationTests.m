//
//  StackOverflowManagerTests.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 14/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "QuestionCreationTests.h"
#import "StackOverflowManager.h"
#import "MockStackOverflowManagerDelegate.h"
#import "MockStackOverflowCommunicator.h"
#import "FakeQuestionBuilder.h"
#import "Topic.h"

@implementation QuestionCreationTests

- (void)setUp {
    mgr = [[StackOverflowManager alloc] init];
    delegate = [[MockStackOverflowManagerDelegate alloc] init];
    mgr.delegate = delegate;
    underlyingError = [[NSError errorWithDomain: @"Test domain" code: 0 userInfo: nil] retain];
}

- (void)tearDown {
    [mgr release];
    [delegate release];
    [underlyingError release];
}

- (void)testNonConformingObjectCannotBeDelegate {
    STAssertThrows(mgr.delegate = [NSNull null], @"NSNull doesn't conform to the delegate protocol");
}

- (void)testConformingObjectCanBeDelegate {
    STAssertNoThrow(mgr.delegate = delegate, @"Object conforming to the delegate protocol can be delegate");
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

- (void)testErrorReturnedToDelegateIsNotErrorNotifiedByCommunicator {
    [mgr searchingForQuestionsFailedWithError: underlyingError];
    STAssertFalse(underlyingError == [delegate fetchError], @"Error should be at the correct level of abstraction");
}

- (void)testErrorReturnedToDelegateDocumentsUnderlyingError {
    [mgr searchingForQuestionsFailedWithError: underlyingError];
    STAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey], underlyingError, @"The underlying error should be available to client code");
}

- (void)testQuestionJSONIsPassedToQuestionBuilder {
    FakeQuestionBuilder *builder = [[FakeQuestionBuilder alloc] init];
    builder.arrayToReturn = nil;
    mgr.questionBuilder = builder;
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    STAssertEqualObjects(builder.JSON, @"Fake JSON", @"Downloaded JSON is sent to the builder");
    mgr.questionBuilder = nil;
    [builder release];
}

- (void)testDelegateNotifiedOfErrorWhenQuestionBuilderFails {
    FakeQuestionBuilder *builder = [[FakeQuestionBuilder alloc] init];
    builder.arrayToReturn = nil;
    builder.errorToSet = underlyingError;
    mgr.questionBuilder = builder;
    [mgr receivedQuestionsJSON: @"Fake JSON"];
    STAssertNotNil([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey], @"The delegate should have found out about the error");
    mgr.questionBuilder = nil;
    [builder release];
}
@end
