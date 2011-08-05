//
//  EmptyTableViewDelegate.h
//  BrowseOverflow
//
//  Created by Graham Lee on 27/07/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopicTableDataSource;

@interface TopicTableDelegate : NSObject <UITableViewDelegate>

@property (strong) TopicTableDataSource *tableDataSource;

@end

