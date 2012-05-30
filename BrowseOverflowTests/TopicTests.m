//
//  TopicTests.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 17/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "TopicTests.h"
#import "Topic.h"
#import "Question.h"

@implementation TopicTests
{
    Question *questionWithID123;
}

- (void)setUp {
    topic = [[Topic alloc] initWithName: @"iPhone" tag: @"iphone"];
    questionWithID123 = [[Question alloc] init];
    questionWithID123.questionID = 123;
}

- (void)tearDown {
}

- (void)testThatTopicExists {
    STAssertNotNil(topic, @"should be able to create a Topic instance");
}

- (void)testThatTopicCanBeNamed {
    STAssertEqualObjects(topic.name, @"iPhone", @"the Topic should have the name I gave it");
}

- (void)testThatTopicHasATag {
    STAssertEqualObjects(topic.tag, @"iphone", @"the Topic should have the tag I gave it");
}

- (void)testForAListOfQuestions {
    STAssertTrue([[topic recentQuestions] isKindOfClass: [NSArray class]], @"Topics should provide a list of recent questions");
}

- (void)testForInitiallyEmptyQuestionList {
    STAssertEquals([[topic recentQuestions] count], (NSUInteger)0, @"No questions added yet, count should be zero");
}

- (void)testAddingAQuestionToTheList {
    [topic addQuestion: questionWithID123];
    STAssertEquals([[topic recentQuestions] count], (NSUInteger)1, @"Add a question, and the count of questions should go up");
}

- (void)testQuestionsAreListedChronologically {
    Question *q1 = [[Question alloc] init];
    q1.questionID = 1;
    q1.date = [NSDate distantPast];
    
    Question *q2 = [[Question alloc] init];
    q2.questionID = 2;
    q2.date = [NSDate distantFuture];
    
    [topic addQuestion: q1];
    [topic addQuestion: q2];
    
    NSArray *questions = [topic recentQuestions];
    Question *listedFirst = [questions objectAtIndex: 0];
    Question *listedSecond = [questions objectAtIndex: 1];
    
    STAssertEqualObjects([listedFirst.date laterDate: listedSecond.date], listedFirst.date, @"The later question should appear first in the list");
}

- (void)testLimitOfTwentyQuestions {
    for (NSInteger i = 0; i < 25; i++) {
        Question *q = [[Question alloc] init];
        q.questionID = i;
        [topic addQuestion: q];
    }
    STAssertTrue([[topic recentQuestions] count] < 21, @"There should never be more than twenty questions");
}

- (void)testThatTheSameQuestionCannotBeAddedTwiceToTheList {
    for (NSInteger i = 0; i < 2; i++) {
        [topic addQuestion: questionWithID123];
    }
    STAssertEquals([[topic recentQuestions] count], (NSUInteger)1, @"Adding the same question twice should only yield one entry");
}

- (void)testThatDifferentQuestionsWithTheSameValueCannotBothBeInTheList {
    Question *alsoQ123 = [[Question alloc] init];
    alsoQ123.questionID = 123;
    [topic addQuestion: questionWithID123];
    [topic addQuestion: alsoQ123];
    STAssertEquals([[topic recentQuestions] count], (NSUInteger)1, @"Adding questions with the same value should only yield one entry");
}
@end
