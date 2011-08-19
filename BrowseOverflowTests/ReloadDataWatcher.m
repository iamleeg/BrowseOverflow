//
//  ReloadDataWatcher.m
//  BrowseOverflow
//
//  Created by Graham Lee on 19/08/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "ReloadDataWatcher.h"

@implementation ReloadDataWatcher
{
    BOOL didReloadData;
}

- (void)reloadData {
    didReloadData = YES;
}

- (BOOL)didReceiveReloadData {
    return didReloadData;
}
@end
