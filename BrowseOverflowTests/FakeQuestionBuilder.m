//
//  FakeQuestionBuilder.m
//  BrowseOverflow
//
//  Created by Graham Lee on 30/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "FakeQuestionBuilder.h"
#import "Question.h"

@implementation FakeQuestionBuilder

@synthesize JSON;
@synthesize arrayToReturn;
@synthesize errorToSet;
@synthesize questionToFill;

- (NSArray *)questionsFromJSON: (NSString *)objectNotation error: (NSError **)error {
    self.JSON = objectNotation;
    if (error) {
        *error = errorToSet;
    }
    return arrayToReturn;
}

- (void)fillInDetailsForQuestion:(Question *)question fromJSON:(NSString *)objectNotation {
    self.JSON = objectNotation;
    self.questionToFill = question;
}

@end
