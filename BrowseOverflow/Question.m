//
//  Question.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 21/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "Question.h"

@implementation Question

@synthesize date;
@synthesize title;
@synthesize body;
@synthesize score;
@synthesize questionID;
@synthesize asker;

- (id)init {
    if ((self = [super init])) {
        answerSet = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)addAnswer:(Answer *)answer {
    [answerSet addObject: answer];
}

- (NSArray *)answers {
    return [[answerSet allObjects] sortedArrayUsingSelector: @selector(compare:)];
}

- (void)dealloc {
    [date release];
    [title release];
    [body release];
    [answerSet release];
    [asker release];
    [super dealloc];
}

@end
