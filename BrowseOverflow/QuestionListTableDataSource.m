//
//  QuestionListTableDataSource.m
//  BrowseOverflow
//
//  Created by Graham Lee on 11/08/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "QuestionListTableDataSource.h"
#import "Topic.h"

@implementation QuestionListTableDataSource 

@synthesize topic;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[topic recentQuestions] count] ?: 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
