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

- (void)setUp {
    topic = [[Topic alloc] initWithName: @"iPhone" tag: @"iphone"];
}

- (void)tearDown {
    [topic release];
    topic = nil;
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
    Question *question = [[Question alloc] init];
    [topic addQuestion: question];
    STAssertEquals([[topic recentQuestions] count], (NSUInteger)1, @"Add a question, and the count of questions should go up");
    [question release];
}

- (void)testQuestionsAreListedChronologically {
    Question *q1 = [[Question alloc] init];
    q1.date = [NSDate distantPast];
    
    Question *q2 = [[Question alloc] init];
    q2.date = [NSDate distantFuture];
    
    [topic addQuestion: q1];
    [topic addQuestion: q2];
    
    NSArray *questions = [topic recentQuestions];
    Question *listedFirst = [questions objectAtIndex: 0];
    Question *listedSecond = [questions objectAtIndex: 1];
    
    STAssertEqualObjects([listedFirst.date laterDate: listedSecond.date], listedFirst.date, @"The later question should appear first in the list");
}

- (void)testLimitOfTwentyQuestions {
    Question *q1 = [[Question alloc] init];
    for (NSInteger i = 0; i < 25; i++) {
        [topic addQuestion: q1];
    }
    STAssertTrue([[topic recentQuestions] count] < 21, @"There should never be more than twenty questions");
}

@end
