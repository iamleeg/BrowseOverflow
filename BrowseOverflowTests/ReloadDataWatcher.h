//
//  ReloadDataWatcher.h
//  BrowseOverflow
//
//  Created by Graham Lee on 19/08/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReloadDataWatcher : NSObject

- (void)reloadData;
- (BOOL)didReceiveReloadData;

@end
