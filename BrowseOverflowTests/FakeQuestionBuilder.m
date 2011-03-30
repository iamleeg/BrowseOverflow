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

- (NSArray *)questionsFromJSON: (NSString *)objectNotation error: (NSError **)error {
    self.JSON = objectNotation;
    return nil;
}

- (void)dealloc {
    [JSON release];
    [super dealloc];
}
@end
