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

- (void)testTopicDataSourceCanReceiveAListOfTopics {
    TopicTableDataSource *dataSource = [[TopicTableDataSource alloc] init];
    Topic *sampleTopic = [[Topic alloc] initWithName: @"iPhone" tag: @"iphone"];
    NSArray *topicsList = [NSArray arrayWithObject: sampleTopic];
    STAssertNoThrow([dataSource setTopics: topicsList], @"The data source needs a list of topics");
}

@end
