//
//  AnswerBuilderTests.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 04/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "AnswerBuilderTests.h"
#import "AnswerBuilder.h"
#import "Question.h"

static NSString *stringIsNotJSON = @"Not JSON";

@implementation AnswerBuilderTests

- (void)setUp {
    answerBuilder = [[AnswerBuilder alloc] init];
    question = [[Question alloc] init];
    question.questionID = 12345;
}

- (void)tearDown {
    [answerBuilder release];
    answerBuilder = nil;
    [question release];
    question = nil;
}

- (void)testThatSendingNilJSONIsNotAnOption {
    STAssertThrows([answerBuilder addAnswersToQuestion: question fromJSON: nil error: NULL], @"Not having data should have already been handled");
}

- (void)testThatAddingAnswersToNilQuestionIsNotSupported {
    STAssertThrows([answerBuilder addAnswersToQuestion: nil fromJSON: stringIsNotJSON error: NULL], @"Makes no sense to have answers without a question");
}

@end
