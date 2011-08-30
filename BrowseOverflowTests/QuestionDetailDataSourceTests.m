//
//  QuestionDetailDataSourceTests.m
//  BrowseOverflow
//
//  Created by Graham Lee on 30/08/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "QuestionDetailDataSourceTests.h"
#import "QuestionDetailDataSource.h"
#import "Question.h"
#import "Person.h"
#import "Answer.h"

@implementation QuestionDetailDataSourceTests
{
    QuestionDetailDataSource *dataSource;
    Question *question;
    Answer *answer1, *answer2;
}

- (void)setUp {
    dataSource = [[QuestionDetailDataSource alloc] init];
    question = [[Question alloc] init];
    answer1 = [[Answer alloc] init];
    answer2 = [[Answer alloc] init];
    [question addAnswer: answer1];
    [question addAnswer: answer2];
    dataSource.question = question;
}

- (void)tearDown {
    dataSource = nil;
    question = nil;
    answer1 = nil;
    answer2 = nil;
}

- (void)testTwoSectionsInTheTableView {
    STAssertEquals([dataSource numberOfSectionsInTableView: nil], (NSInteger)2, @"Always two sections in the table view");
}

- (void)testOneRowInTheFirstSection {
    STAssertEquals([dataSource tableView: nil numberOfRowsInSection: 0], (NSInteger)1, @"Always one row in section 0");
}

- (void)testOneRowPerAnswerInTheSecondSection {
    STAssertEquals([dataSource tableView: nil numberOfRowsInSection: 1], (NSInteger)2, @"One row per answer in section 1");
}

@end
