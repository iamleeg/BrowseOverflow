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
    UITableViewCell *cell = nil;
    if ([topic.recentQuestions count]) {
        cell = [tableView dequeueReusableCellWithIdentifier: @"question"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"question"];
        }
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier: @"placeholder"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"placeholder"];
        }
        cell.textLabel.text = @"There was a problem connecting to the network.";
    }
    return cell;
}

@end
