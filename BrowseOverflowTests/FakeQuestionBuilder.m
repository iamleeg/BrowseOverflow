//
//  FakeQuestionBuilder.m
//  BrowseOverflow
//
//  Created by Graham Lee on 30/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "FakeQuestionBuilder.h"


@implementation FakeQuestionBuilder

@synthesize JSON;
@synthesize arrayToReturn;
@synthesize errorToSet;

- (NSArray *)questionsFromJSON: (NSString *)objectNotation error: (NSError **)error {
    self.JSON = objectNotation;
    if (error) {
        *error = errorToSet;
    }
    return arrayToReturn;
}

- (void)dealloc {
    [JSON release];
    [arrayToReturn release];
    [errorToSet release];
    [super dealloc];
}

@end
