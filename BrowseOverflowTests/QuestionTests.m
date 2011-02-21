//
//  QuestionTests.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 21/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "QuestionTests.h"
#import "Question.h"

@implementation QuestionTests

- (void)testQuestionHasADate {
    Question *question = [[Question alloc] init];
    NSDate *testDate = [NSDate distantPast];
    question.askedDate = testDate;
    STAssertEqualObjects(question.askedDate, testDate, @"Question needs to provide its date");
    [question release];
}

@end
