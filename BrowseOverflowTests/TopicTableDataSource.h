//
//  EmptyTableViewDataSource.h
//  BrowseOverflow
//
//  Created by Graham Lee on 27/07/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

- (void)setTopics: (NSArray *)newTopics;

@end

extern NSString *TopicTableDidSelectTopicNotification;