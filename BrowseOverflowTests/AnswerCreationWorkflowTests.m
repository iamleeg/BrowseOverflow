//
//  AnswerCreationWorkflowTests.m
//  BrowseOverflow
//
//  Created by Graham Lee on 25/04/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "AnswerCreationWorkflowTests.h"
#import "Question.h"
#import "StackOverflowManager.h"
#import "MockStackOverflowCommunicator.h"
#import "MockStackOverflowManagerDelegate.h"
#import "FakeAnswerBuilder.h"

@implementation AnswerCreationWorkflowTests

- (void)setUp {
    manager = [[StackOverflowManager alloc] init];
    communicator = [[MockStackOverflowCommunicator alloc] init];
    manager.communicator = communicator;
    delegate = [[MockStackOverflowManagerDelegate alloc] init];
    manager.delegate = delegate;
    question = [[Question alloc] init];
    question.questionID = 12345;
    answerBuilder = [[FakeAnswerBuilder alloc] init];
    manager.answerBuilder = answerBuilder;
}

- (void)tearDown {
    [answerBuilder release];
    answerBuilder = nil;
    [question release];
    question = nil;
    [delegate release];
    delegate = nil;
    [communicator release];
    communicator = nil;
    [manager release];
    manager = nil;
}

- (void)testAskingForAnswersMeansCommunicatingWithSite {
    [manager fetchAnswersForQuestion: question];
    STAssertEquals(question.questionID, [communicator askedForAnswersToQuestionID], @"Answers to questions are found by communicating with the web site");
}

- (void)testDelegateNotifiedOfFailureToGetAnswers {
    NSError *error = [NSError errorWithDomain: @"Fake Domain" code: 42 userInfo: nil];
    [manager fetchingAnswersFailedWithError: error];
    STAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey], error, @"Delegate should be notified of failure to communicate");
}

- (void)testManagerRemembersWhichQuestionToAddAnswersTo {
    [manager fetchAnswersForQuestion: question];
    STAssertEqualObjects(manager.questionToFill, question, @"Manager should know to fill this question in");
}

- (void)testAnswerResponsePassedToAnswerBuilder {
    [manager receivedAnswerListJSON: @"Fake JSON"];
    STAssertEqualObjects([answerBuilder receivedJSON], @"Fake JSON", @"Manager must pass response to builder to get answers constructed");
}

- (void)testQuestionPassedToAnwerBuilder {
    manager.questionToFill = question;
    [manager receivedAnswerListJSON: @"Fake JSON"];
    STAssertEqualObjects(answerBuilder.questionToFill, question, @"Manager must pass the question into the answer builder");
}

@end
