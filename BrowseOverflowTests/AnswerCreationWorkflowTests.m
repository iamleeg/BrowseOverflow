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

@implementation AnswerCreationWorkflowTests

- (void)setUp {
    manager = [[StackOverflowManager alloc] init];
    communicator = [[MockStackOverflowCommunicator alloc] init];
    manager.communicator = communicator;
    delegate = [[MockStackOverflowManagerDelegate alloc] init];
    manager.delegate = delegate;
    
}

- (void)tearDown {
    [delegate release];
    delegate = nil;
    [communicator release];
    communicator = nil;
    [manager release];
    manager = nil;
}

- (void)testAskingForAnswersMeansCommunicatingWithSite {
    Question *question = [[Question alloc] init];
    question.questionID = 12345;
    [manager fetchAnswersForQuestion: question];
    STAssertEquals(question.questionID, [communicator askedForAnswersToQuestionID], @"Answers to questions are found by communicating with the web site");
}

- (void)testDelegateNotifiedOfFailureToGetAnswers {
    NSError *error = [NSError errorWithDomain: @"Fake Domain" code: 42 userInfo: nil];
    [manager fetchingAnswersFailedWithError: error];
    STAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey], error, @"Delegate should be notified of failure to communicate");
}
@end
