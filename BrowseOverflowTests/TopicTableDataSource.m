//
//  EmptyTableViewDataSource.m
//  BrowseOverflow
//
//  Created by Graham Lee on 27/07/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "TopicTableDataSource.h"
#import "Topic.h"

@implementation TopicTableDataSource
{
    NSArray *topics;
}

- (void)setTopics: (NSArray *)newTopics {
    topics = newTopics;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
