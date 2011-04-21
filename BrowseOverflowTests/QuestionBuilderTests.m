//
//  QuestionBuilderTests.m
//  BrowseOverflow
//
//  Created by Graham Lee on 01/04/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "QuestionBuilderTests.h"
#import "QuestionBuilder.h"

@implementation QuestionBuilderTests

- (void)setUp {
    questionBuilder = [[QuestionBuilder alloc] init];
    stringIsNotJSON = @"Not JSON";
    noQuestionsJSONString = @"{ \"noquestions\": true }";
}

- (void)tearDown {
    [questionBuilder release];
    questionBuilder = nil;
}

- (void)testThatNilIsNotAnAcceptableParameter {
    STAssertThrows([questionBuilder questionsFromJSON: nil error: NULL], @"Lack of data should have been handled elsewhere");
}

- (void)testNilReturnedWhenStringIsNotJSON {
    STAssertNil([questionBuilder questionsFromJSON: stringIsNotJSON error: NULL], @"This parameter should not be parsable");
}

- (void)testErrorSetWhenStringIsNotJSON {
    NSError *error = nil;
    [questionBuilder questionsFromJSON: stringIsNotJSON error: &error];
    STAssertNotNil(error, @"An error occurred, we should be told");
}

- (void)testPassingNullErrorDoesNotCauseCrash {
    STAssertNoThrow([questionBuilder questionsFromJSON: stringIsNotJSON error: NULL], @"Using a NULL error parameter should not be a problem");
}

- (void)testRealJSONWithoutQuestionsArrayIsError {
    STAssertNil([questionBuilder questionsFromJSON: noQuestionsJSONString error: NULL], @"No questions to parse in this JSON");
}

- (void)testRealJSONWithoutQuestionsReturnsMissingDataError {
    NSError *error = nil;
    [questionBuilder questionsFromJSON: noQuestionsJSONString error: &error];
    STAssertEquals([error code], QuestionBuilderMissingDataError, @"This case should not be an invalid JSON error");
}

@end
