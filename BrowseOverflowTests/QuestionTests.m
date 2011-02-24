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

- (void)setUp {
    question = [[Question alloc] init];
    question.askedDate = [NSDate distantPast];
    question.title = @"Do iPhones also dream of electric sheep?";
}

- (void)tearDown {
    [question release];
}

- (void)testQuestionHasATitle {
    STAssertEqualObjects(question.title, @"Do iPhones also dream of electric sheep?", @"Question should know its title");
}

- (void)testQuestionHasADate {
    STAssertEqualObjects(question.askedDate, [NSDate distantPast], @"Question needs to provide its date");
}

@end
