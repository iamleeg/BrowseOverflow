//
//  QuestionDetailDataSource.m
//  BrowseOverflow
//
//  Created by Graham Lee on 30/08/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "QuestionDetailDataSource.h"
#import "Question.h"

enum {
    questionSection = 0,
    answerSection = 1
    };

@implementation QuestionDetailDataSource

@synthesize question;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == answerSection) ? [question.answers count] : 1; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

@end
