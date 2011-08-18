//
//  QuestionListTableDataSource.h
//  BrowseOverflow
//
//  Created by Graham Lee on 11/08/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Topic;
@class QuestionSummaryCell;
@class AvatarStore;

@interface QuestionListTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (strong) Topic *topic;
@property (weak) IBOutlet QuestionSummaryCell *summaryCell;
@property (strong) AvatarStore *avatarStore;

- (void)registerForUpdatesToAvatarStore: (AvatarStore *)store withNotificationCenter: (NSNotificationCenter *)center;
@end
