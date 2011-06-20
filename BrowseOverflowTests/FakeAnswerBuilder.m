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
@synthesize successful;
@synthesize error;

- (BOOL)addAnswersToQuestion: (Question *)question fromJSON: (NSString *)objectNotation error: (NSError **)addError {
    self.questionToFill = question;
    self.receivedJSON = objectNotation;
    if (addError) {
        *addError = error;
    }
    return successful;
}

@end
