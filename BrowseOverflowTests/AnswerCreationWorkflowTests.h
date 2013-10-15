//
//  AnswerCreationWorkflowTests.h
//  BrowseOverflow
//
//  Created by Graham Lee on 25/04/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>

@class StackOverflowManager;
@class MockStackOverflowCommunicator;
@class MockStackOverflowManagerDelegate;
@class Question;
@class FakeAnswerBuilder;

@interface AnswerCreationWorkflowTests : XCTestCase {
    StackOverflowManager *manager;
    MockStackOverflowCommunicator *communicator;
    MockStackOverflowManagerDelegate *delegate;
    Question *question;
    FakeAnswerBuilder *answerBuilder;
    NSError *error;
}

@end
