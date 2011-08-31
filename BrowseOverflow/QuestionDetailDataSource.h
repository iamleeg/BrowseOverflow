//
//  QuestionDetailDataSource.h
//  BrowseOverflow
//
//  Created by Graham Lee on 30/08/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;
@class QuestionDetailCell;

@interface QuestionDetailDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (strong) Question *question;
@property (weak) IBOutlet QuestionDetailCell *detailCell;

@end
