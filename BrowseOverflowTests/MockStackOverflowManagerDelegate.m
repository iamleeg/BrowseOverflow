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
@synthesize fetchedQuestions;

- (void)fetchingQuestionsFailedWithError: (NSError *)error {
    self.fetchError = error;
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error {
    self.fetchError = error;
}

- (void)questionsReceived:(NSArray *)questions {
    self.fetchedQuestions = questions;
}

- (void)dealloc {
    [fetchError release];
    [fetchedQuestions release];
    [super dealloc];
}
@end
