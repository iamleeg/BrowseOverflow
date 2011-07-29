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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert([indexPath section] == 0);
    NSParameterAssert([indexPath row] < [topics count]);
    UITableViewCell *topicCell = [tableView dequeueReusableCellWithIdentifier: topicCellReuseIdentifier];
    if (!topicCell) {
        topicCell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: topicCellReuseIdentifier];
    }
    topicCell.textLabel.text = [[topics objectAtIndex: [indexPath row]] name];
    return topicCell;
}

@end
