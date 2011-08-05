//
//  EmptyTableViewDataSource.m
//  BrowseOverflow
//
//  Created by Graham Lee on 27/07/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "TopicTableDataSource.h"
#import "Topic.h"

NSString *topicCellReuseIdentifier = @"Topic";

@interface TopicTableDataSource ()

- (Topic *)topicForIndexPath: (NSIndexPath *)indexPath;

@end

@implementation TopicTableDataSource
{
    NSArray *topics;
}

- (void)setTopics: (NSArray *)newTopics {
    topics = newTopics;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSParameterAssert(section == 0);
    return [topics count];
}

- (Topic *)topicForIndexPath:(NSIndexPath *)indexPath {
    return [topics objectAtIndex: [indexPath row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert([indexPath section] == 0);
    NSParameterAssert([indexPath row] < [topics count]);
    UITableViewCell *topicCell = [tableView dequeueReusableCellWithIdentifier: topicCellReuseIdentifier];
    if (!topicCell) {
        topicCell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: topicCellReuseIdentifier];
    }
    topicCell.textLabel.text = [[self topicForIndexPath: indexPath] name];
    return topicCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNotification *note = [NSNotification notificationWithName: TopicTableDidSelectTopicNotification object: [self topicForIndexPath: indexPath]];
    [[NSNotificationCenter defaultCenter] postNotification: note];
}

@end

NSString *TopicTableDidSelectTopicNotification = @"TopicTableDidSelectTopicNotification";