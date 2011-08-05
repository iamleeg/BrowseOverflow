//
//  EmptyTableViewDelegate.m
//  BrowseOverflow
//
//  Created by Graham Lee on 27/07/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "TopicTableDelegate.h"
#import "TopicTableDataSource.h"

@implementation TopicTableDelegate

@synthesize tableDataSource;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNotification *note = [NSNotification notificationWithName: TopicTableDidSelectTopicNotification object: [tableDataSource topicForIndexPath: indexPath]];
    [[NSNotificationCenter defaultCenter] postNotification: note];
}

@end

NSString *TopicTableDidSelectTopicNotification = @"TopicTableDidSelectTopicNotification";