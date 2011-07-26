//
//  BrowseOverflowViewController.h
//  BrowseOverflow
//
//  Created by Graham Lee on 25/07/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseOverflowViewController : UIViewController

@property (strong) UITableView *tableView;
@property (strong) id <UITableViewDataSource> dataSource;
@property (strong) id <UITableViewDelegate> delegate;

@end
