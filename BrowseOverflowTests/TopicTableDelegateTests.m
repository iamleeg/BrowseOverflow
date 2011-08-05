//
//  TopicTableDelegateTests.m
//  BrowseOverflow
//
//  Created by Graham Lee on 04/08/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "TopicTableDelegateTests.h"
#import "TopicTableDelegate.h"
#import "TopicTableDataSource.h"
#import "Topic.h"

@implementation TopicTableDelegateTests
{
    NSNotification *receivedNotification;
    TopicTableDataSource *dataSource;
    TopicTableDelegate *delegate;
    Topic *iPhoneTopic;
}

- (void)setUp {
    delegate = [[TopicTableDelegate alloc] init];
    dataSource = [[TopicTableDataSource alloc] init];
    iPhoneTopic = [[Topic alloc] initWithName: @"iPhone" tag: @"iphone"];
    [dataSource setTopics: [NSArray arrayWithObject: iPhoneTopic]];
    delegate.tableDataSource = dataSource;
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(didReceiveNotification:) name: TopicTableDidSelectTopicNotification object: nil];
}

- (void)tearDown {
    receivedNotification = nil;
    dataSource = nil;
    delegate = nil;
    iPhoneTopic = nil;
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)didReceiveNotification: (NSNotification *)note {
    receivedNotification = note;
}

- (void)testDelegatePostsNotificationOnSelectionShowingWhichTopicWasSelected {
    NSIndexPath *selection = [NSIndexPath indexPathForRow: 0 inSection: 0];
    [delegate tableView: nil didSelectRowAtIndexPath: selection];
    STAssertEqualObjects([receivedNotification name], @"TopicTableDidSelectTopicNotification", @"The delegate should notify that a topic was selected");
    STAssertEqualObjects([receivedNotification object], iPhoneTopic, @"The notification should indicate which topic was selected");
}

@end
