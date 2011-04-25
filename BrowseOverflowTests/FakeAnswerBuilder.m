//
//  FakeAnswerBuilder.m
//  BrowseOverflow
//
//  Created by Graham Lee on 25/04/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "FakeAnswerBuilder.h"


@implementation FakeAnswerBuilder

@synthesize receivedJSON;

- (BOOL)addAnswersToQuestion: (Question *)question fromJSON: (NSString *)objectNotation error: (NSError **)error {
    self.receivedJSON = objectNotation;
    return YES;
}

- (void)dealloc {
    [receivedJSON release];
    [super dealloc];
}

@end
