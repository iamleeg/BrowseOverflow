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
    question.date = [NSDate distantPast];
    question.title = @"Do iPhones also dream of electric sheep?";
    question.score = 42;
}

- (void)tearDown {
    [question release];
    question = nil;
}

- (void)testQuestionHasATitle {
    STAssertEqualObjects(question.title, @"Do iPhones also dream of electric sheep?", @"Question should know its title");
}

- (void)testQuestionHasADate {
    STAssertEqualObjects(question.date, [NSDate distantPast], @"Question needs to provide its date");
}

- (void)testQuestionKeepsScore {
    STAssertEquals(question.score, 42, @"Questions need a numeric score");
}
@end
