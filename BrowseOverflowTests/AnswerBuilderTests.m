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
#import "Answer.h"
#import "Person.h"

static NSString *realAnswerJSON = @"{"
@"\"total\": 1,"
@"\"page\": 1,"
@"\"pagesize\": 30,"
@"\"answers\": ["
@"{"
@"\"answer_id\": 3231900,"
@"\"accepted\": true,"
@"\"answer_comments_url\": \"/answers/3231900/comments\","
@"\"question_id\": 2817980,"
@"\"owner\": {"
@"\"user_id\": 266380,"
@"\"user_type\": \"registered\","
@"\"display_name\": \"dmaclach\","
@"\"reputation\": 151,"
@"\"email_hash\": \"d96ae876eac0075727243a10fab823b3\""
@"},"
@"\"creation_date\": 1278965736,"
@"\"last_activity_date\": 1278965736,"
@"\"up_vote_count\": 1,"
@"\"down_vote_count\": 0,"
@"\"view_count\": 0,"
@"\"score\": 1,"
@"\"community_owned\": false,"
@"\"title\": \"Why does Keychain Services return the wrong keychain content?\","
@"\"body\": \"<p>Turns out that using the kSecMatchItemList doesn't appear to work at all. </p>\""
@"}"
@"]"
@"}";

static NSString *stringIsNotJSON = @"Not JSON";
static NSString *noAnswersJSONString = @"{ \"noanswers\": true }";

@implementation AnswerBuilderTests

- (void)setUp {
    answerBuilder = [[AnswerBuilder alloc] init];
    question = [[Question alloc] init];
    question.questionID = 12345;
}

- (void)testThatSendingNilJSONIsNotAnOption {
    XCTAssertThrows([answerBuilder addAnswersToQuestion: question fromJSON: nil error: NULL], @"Not having data should have already been handled");
}

- (void)testThatAddingAnswersToNilQuestionIsNotSupported {
    XCTAssertThrows([answerBuilder addAnswersToQuestion: nil fromJSON: stringIsNotJSON error: NULL], @"Makes no sense to have answers without a question");
}

- (void)testSendingNonJSONIsAnError {
    NSError *error = nil;
    XCTAssertFalse([answerBuilder addAnswersToQuestion: question fromJSON: stringIsNotJSON error: &error], @"Can't successfully create answers without real data");
    XCTAssertEqualObjects([error domain], AnswerBuilderErrorDomain, @"This should be an AnswerBuilder error");
}

- (void)testErrorParameterMayBeNULL {
    XCTAssertNoThrow([answerBuilder addAnswersToQuestion: question fromJSON: stringIsNotJSON error: NULL], @"AnswerBuilder should handle a NULL pointer gracefully");
}

- (void)testSendingJSONWithIncorrectKeysIsAnError {
    NSError *error = nil;
    XCTAssertFalse([answerBuilder addAnswersToQuestion: question fromJSON: noAnswersJSONString error: &error], @"There must be a collection of answers in the input data");
}

- (void)testAddingRealAnswerJSONIsNotAnError {
    XCTAssertTrue([answerBuilder addAnswersToQuestion: question fromJSON: realAnswerJSON error: NULL], @"Should be OK to actually want to add answers");
}

- (void)testNumberOfAnswersAddedMatchNumberInData {
    [answerBuilder addAnswersToQuestion: question fromJSON: realAnswerJSON error: NULL];
    XCTAssertEqual([question.answers count], (NSUInteger)1, @"One answer added to zero should mean one answer");
}

- (void)testAnswerPropertiesMatchDataReceived {
    [answerBuilder addAnswersToQuestion: question fromJSON: realAnswerJSON error: NULL];
    Answer *answer = [question.answers objectAtIndex: 0];
    XCTAssertEqual(answer.score, (NSInteger)1, @"Score property should be set from JSON");
    XCTAssertTrue(answer.accepted, @"Answer should be accepted as in JSON data");
    XCTAssertEqualObjects(answer.text, @"<p>Turns out that using the kSecMatchItemList doesn't appear to work at all. </p>", @"Answer body should match fed data");
}

- (void)testAnswerIsProvidedByExpectedPerson {
    [answerBuilder addAnswersToQuestion: question fromJSON: realAnswerJSON error: NULL];
    Answer *answer = [question.answers objectAtIndex: 0];
    Person *answerer = answer.person;
    XCTAssertEqualObjects(answerer.name, @"dmaclach", @"The provided person name was used");
    XCTAssertEqualObjects([answerer.avatarURL absoluteString], @"http://www.gravatar.com/avatar/d96ae876eac0075727243a10fab823b3", @"The provided email hash was converted to an avatar URL");
}
@end
