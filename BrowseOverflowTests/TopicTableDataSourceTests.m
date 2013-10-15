//
//  TopicTableDataSourceTests.m
//  BrowseOverflow
//
//  Created by Graham Lee on 28/07/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "TopicTableDataSourceTests.h"
#import "TopicTableDataSource.h"
#import "Topic.h"

@implementation TopicTableDataSourceTests
{
    TopicTableDataSource *dataSource;
    NSArray *topicsList;
}

- (void)setUp {
    dataSource = [[TopicTableDataSource alloc] init];
    Topic *sampleTopic = [[Topic alloc] initWithName: @"iPhone" tag: @"iphone"];
    topicsList = [NSArray arrayWithObject: sampleTopic];
    [dataSource setTopics: topicsList];
}

- (void)tearDown {
    dataSource = nil;
    topicsList = nil;
}

- (void)testOneTableRowForOneTopic {
    XCTAssertEqual((NSInteger)[topicsList count], [dataSource tableView: nil numberOfRowsInSection: 0], @"As there's one topic, there should be one row in the table");
}

- (void)testTwoTableRowsForTwoTopics {
    Topic *topic1 = [[Topic alloc] initWithName: @"Mac OS X" tag: @"macosx"];
    Topic *topic2 = [[Topic alloc] initWithName: @"Cocoa" tag: @"cocoa"];
    NSArray *twoTopicsList = [NSArray arrayWithObjects: topic1, topic2, nil];
    [dataSource setTopics: twoTopicsList];
    XCTAssertEqual((NSInteger)[twoTopicsList count], [dataSource tableView: nil numberOfRowsInSection: 0], @"There should be two rows in the table for two topics");
}

- (void)testOneSectionInTheTableView {
    XCTAssertThrows([dataSource tableView: nil numberOfRowsInSection: 1], @"Data source doesn't allow asking about additional sections");
}

- (void)testDataSourceCellCreationExpectsOneSection {
    NSIndexPath *secondSection = [NSIndexPath indexPathForRow: 0 inSection: 1];
    XCTAssertThrows([dataSource tableView: nil cellForRowAtIndexPath: secondSection], @"Data source will not prepare cells for unexpected sections");
}

- (void)testDataSourceCellCreationWillNotCreateMoreRowsThanItHasTopics {
    NSIndexPath *afterLastTopic = [NSIndexPath indexPathForRow: [topicsList count] inSection: 0];
    XCTAssertThrows([dataSource tableView: nil cellForRowAtIndexPath: afterLastTopic], @"Data source will not prepare more cells than there are topics");
}

- (void)testCellCreatedByDataSourceContainsTopicTitleAsTextLabel {
    NSIndexPath *firstTopic = [NSIndexPath indexPathForRow: 0 inSection: 0];
    UITableViewCell *firstCell = [dataSource tableView: nil cellForRowAtIndexPath: firstTopic];
    NSString *cellTitle = firstCell.textLabel.text;
    XCTAssertEqualObjects(@"iPhone", cellTitle, @"Cell's title should be equal to the topic's title");
}

@end
