//
//  BrowseOverflowViewController.h
//  BrowseOverflow
//
//  Created by Graham Lee on 25/07/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BrowseOverflowObjectConfiguration;
@interface BrowseOverflowViewController : UIViewController

@property (strong) IBOutlet UITableView *tableView;
@property (strong) NSObject <UITableViewDataSource, UITableViewDelegate> *dataSource;
@property (strong) BrowseOverflowObjectConfiguration *objectConfiguration;

- (void)userDidSelectTopicNotification: (NSNotification *)note;
- (void)userDidSelectQuestionNotification: (NSNotification *)note;

@end
