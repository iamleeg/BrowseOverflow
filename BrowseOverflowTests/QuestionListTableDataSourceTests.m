//
//  QuestionListTableDataSourceTests.m
//  BrowseOverflow
//
//  Created by Graham Lee on 11/08/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "QuestionListTableDataSourceTests.h"
#import "QuestionListTableDataSource.h"
#import "Topic.h"
#import "Question.h"

@implementation QuestionListTableDataSourceTests
{
    QuestionListTableDataSource *dataSource;
    Topic *iPhoneTopic;
}

- (void)setUp {
    dataSource = [[QuestionListTableDataSource alloc] init];
    iPhoneTopic = [[Topic alloc] initWithName: @"iPhone" tag: @"iphone"];
    dataSource.topic = iPhoneTopic;
}

- (void)tearDown {
    dataSource = nil;
}

- (void)testTopicWithNoQuestionsLeadsToOneRowInTheTable {
    STAssertEquals([dataSource tableView: nil numberOfRowsInSection: 0], (NSInteger)1, @"The table view needs a 'no data yet' placeholder cell");
}

- (void)testTopicWithQuestionsResultsInOneRowPerQuestionInTheTable {
    Question *question1 = [[Question alloc] init];
    question1.title = @"Question One";
    Question *question2 = [[Question alloc] init];
    question2.title = @"Question Two";
    [iPhoneTopic addQuestion: question1];
    [iPhoneTopic addQuestion: question2];
    STAssertEquals([dataSource tableView: nil numberOfRowsInSection: 0], (NSInteger)2, @"Two questions in the topic means two rows in the table");
}
@end
