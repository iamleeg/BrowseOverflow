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

- (void)testJSONWithOneQuestionReturnsOneQuestionObject {
    NSString *jsonString = @"{"
    @"\"total\": 1,"
    @"\"page\": 1,"
    @"\"pagesize\": 30,"
    @"\"questions\": ["
    @"{"
    @"\"tags\": ["
    @"\"iphone\","
    @"\"security\","
    @"\"keychain\""
    @"],"
    @"\"answer_count\": 1,"
    @"\"accepted_answer_id\": 3231900,"
    @"\"favorite_count\": 1,"
    @"\"question_timeline_url\": \"/questions/2817980/timeline\","
    @"\"question_comments_url\": \"/questions/2817980/comments\","
    @"\"question_answers_url\": \"/questions/2817980/answers\","
    @"\"question_id\": 2817980,"
    @"\"owner\": {"
    @"\"user_id\": 23743,"
    @"\"user_type\": \"registered\","
    @"\"display_name\": \"Graham Lee\","
    @"\"reputation\": 13459,"
    @"\"email_hash\": \"563290c0c1b776a315b36e863b388a0c\""
    @"},"
    @"\"creation_date\": 1273660706,"
    @"\"last_activity_date\": 1278965736,"
    @"\"up_vote_count\": 2,"
    @"\"down_vote_count\": 0,"
    @"\"view_count\": 465,"
    @"\"score\": 2,"
    @"\"community_owned\": false,"
    @"\"title\": \"Why does Keychain Services return the wrong keychain content?\""
    @"}"
    @"]"
    @"}";
    NSError *error = nil;
    NSArray *questions = [questionBuilder questionsFromJSON: jsonString error: &error];
    STAssertEquals([questions count], (NSUInteger)1, @"The builder should have created a question");
}
@end
