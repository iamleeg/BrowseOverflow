//
//  MockStackOverflowManagerDelegate.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 14/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"
#import "Topic.h"

@implementation MockStackOverflowManagerDelegate

@synthesize fetchError;

- (void)fetchingQuestionsFailedWithError: (NSError *)error {
    self.fetchError = error;
}

- (void)dealloc {
    [fetchError release];
    [super dealloc];
}
@end
