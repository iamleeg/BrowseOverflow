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
@synthesize questionToFill;

- (BOOL)addAnswersToQuestion: (Question *)question fromJSON: (NSString *)objectNotation error: (NSError **)error {
    self.questionToFill = question;
    self.receivedJSON = objectNotation;
    return YES;
}

- (void)dealloc {
    [receivedJSON release];
    [questionToFill release];
    [super dealloc];
}

@end
