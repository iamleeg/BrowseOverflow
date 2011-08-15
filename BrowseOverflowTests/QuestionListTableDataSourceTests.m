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
    NSIndexPath *firstCell;
    Question *question1, *question2;
}

- (void)setUp {
    dataSource = [[QuestionListTableDataSource alloc] init];
    iPhoneTopic = [[Topic alloc] initWithName: @"iPhone" tag: @"iphone"];
    dataSource.topic = iPhoneTopic;
    firstCell = [NSIndexPath indexPathForRow: 0 inSection: 0];
    question1 = [[Question alloc] init];
    question1.title = @"Question One";
    question2 = [[Question alloc] init];
    question2.title = @"Question Two";

}

- (void)tearDown {
    dataSource = nil;
    iPhoneTopic = nil;
    firstCell = nil;
    question1 = nil;
    question2 = nil;
}

- (void)testTopicWithNoQuestionsLeadsToOneRowInTheTable {
    STAssertEquals([dataSource tableView: nil numberOfRowsInSection: 0], (NSInteger)1, @"The table view needs a 'no data yet' placeholder cell");
}

- (void)testTopicWithQuestionsResultsInOneRowPerQuestionInTheTable {
    [iPhoneTopic addQuestion: question1];
    [iPhoneTopic addQuestion: question2];
    STAssertEquals([dataSource tableView: nil numberOfRowsInSection: 0], (NSInteger)2, @"Two questions in the topic means two rows in the table");
}

- (void)testContentOfPlaceholderCell {
    UITableViewCell *placeholderCell = [dataSource tableView: nil cellForRowAtIndexPath: firstCell];
    STAssertEqualObjects(placeholderCell.textLabel.text, @"There was a problem connecting to the network.", @"The placeholder cell ought to display a placeholder message");
}

- (void)testPlaceholderCellNotReturnedWhenQuestionsExist {
    [iPhoneTopic addQuestion: question1];
    UITableViewCell *cell = [dataSource tableView: nil cellForRowAtIndexPath: firstCell];
    STAssertFalse([cell.textLabel.text isEqualToString: @"There was a problem connecting to the network."], @"Placeholder should only be shown when there's no content");
}
@end
