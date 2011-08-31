//
//  QuestionDetailDataSource.m
//  BrowseOverflow
//
//  Created by Graham Lee on 30/08/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "QuestionDetailDataSource.h"
#import "QuestionDetailCell.h"
#import "Question.h"
#import "Person.h"

enum {
    questionSection = 0,
    answerSection = 1,
    sectionCount
    };

@interface QuestionDetailDataSource ()

- (NSString *)HTMLStringForSnippet: (NSString *)snippet;

@end

@implementation QuestionDetailDataSource

@synthesize question;
@synthesize detailCell;

- (NSString *)HTMLStringForSnippet:(NSString *)snippet {
    NSLog(@"snippit: %@", snippet);
    return [NSString stringWithFormat: @"<html><head></head><body>%@</body></html>", snippet];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == answerSection) ? [question.answers count] : 1; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == questionSection) {
        [[NSBundle bundleForClass: [self class]] loadNibNamed: @"QuestionDetailCell" owner: self options: nil];
        [detailCell.bodyWebView loadHTMLString: [self HTMLStringForSnippet: question.body] baseURL: nil];
        detailCell.titleLabel.text = question.title;
        detailCell.scoreLabel.text = [NSString stringWithFormat: @"%i", question.score];
        detailCell.nameLabel.text = question.asker.name;
        cell = detailCell;
        self.detailCell = nil;
    }
    else if (indexPath.section == answerSection) {
        
    }
    else {
        NSParameterAssert(indexPath.section < sectionCount);
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

@end
