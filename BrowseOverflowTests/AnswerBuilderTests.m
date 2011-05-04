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
@"\"body\": \"<p>Turns out that using the kSecMatchItemList doesn't appear to work at all. </p>\\n\\n<p>I did mine like this:</p>\\n\\n<pre><code>NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:\\n                     (id)kSecClassGenericPassword, kSecClass,\\n                     persistentRef, (id)kSecValuePersistentRef,\\n                     (id)kCFBooleanTrue, kSecReturnAttributes,\\n                     (id)kCFBooleanTrue, kSecReturnData,\\n                     nil];\\nNSDictionary *result = nil;\\nOSStatus status = SecItemCopyMatching((CFDictionaryRef)query,\\n                                    (CFTypeRef*)&result);\\n</code></pre>\\n\\n<p>which returned the attributes and data for the persistent reference. The documentation in the header about converting a \\\"persistent reference\\\" into a \\\"standard reference\\\" makes no sense at all. Hope this helps.</p>\\n\""
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
    error = nil;
}

- (void)tearDown {
    [answerBuilder release];
    answerBuilder = nil;
    [question release];
    question = nil;
    error = nil;
}

- (void)testThatSendingNilJSONIsNotAnOption {
    STAssertThrows([answerBuilder addAnswersToQuestion: question fromJSON: nil error: NULL], @"Not having data should have already been handled");
}

- (void)testThatAddingAnswersToNilQuestionIsNotSupported {
    STAssertThrows([answerBuilder addAnswersToQuestion: nil fromJSON: stringIsNotJSON error: NULL], @"Makes no sense to have answers without a question");
}

- (void)testSendingNonJSONIsAnError {
    STAssertFalse([answerBuilder addAnswersToQuestion: question fromJSON: stringIsNotJSON error: &error], @"Can't successfully create answers without real data");
    STAssertEqualObjects([error domain], AnswerBuilderErrorDomain, @"This should be an AnswerBuilder error");
}

- (void)testErrorParameterMayBeNULL {
    STAssertNoThrow([answerBuilder addAnswersToQuestion: question fromJSON: stringIsNotJSON error: NULL], @"AnswerBuilder should handle a NULL pointer gracefully");
}

- (void)testSendingJSONWithIncorrectKeysIsAnError {
    STAssertFalse([answerBuilder addAnswersToQuestion: question fromJSON: noAnswersJSONString error: &error], @"There must be a collection of answers in the input data");
}

- (void)testAddingRealAnswerJSONIsNotAnError {
    STAssertTrue([answerBuilder addAnswersToQuestion: question fromJSON: realAnswerJSON error: NULL], @"Should be OK to actually want to add answers");
}

- (void)testNumberOfAnswersAddedMatchNumberInData {
    [answerBuilder addAnswersToQuestion: question fromJSON: realAnswerJSON error: NULL];
    STAssertEquals([question.answers count], (NSUInteger)1, @"One answer added to zero should mean one answer");
}
@end
