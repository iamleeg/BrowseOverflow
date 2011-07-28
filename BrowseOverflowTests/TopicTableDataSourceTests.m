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
    STAssertEquals((NSInteger)[topicsList count], [dataSource tableView: nil numberOfRowsInSection: 0], @"As there's one topic, there should be one row in the table");
}

- (void)testTwoTableRowsForTwoTopics {
    Topic *topic1 = [[Topic alloc] initWithName: @"Mac OS X" tag: @"macosx"];
    Topic *topic2 = [[Topic alloc] initWithName: @"Cocoa" tag: @"cocoa"];
    NSArray *twoTopicsList = [NSArray arrayWithObjects: topic1, topic2, nil];
    [dataSource setTopics: twoTopicsList];
    STAssertEquals((NSInteger)[twoTopicsList count], [dataSource tableView: nil numberOfRowsInSection: 0], @"There should be two rows in the table for two topics");
}

- (void)testOneSectionInTheTableView {
    STAssertThrows([dataSource tableView: nil numberOfRowsInSection: 1], @"Data source doesn't allow asking about additional sections");
}

@end
