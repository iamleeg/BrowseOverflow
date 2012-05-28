//
//  Question.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 21/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "Question.h"
#import "Person.h"

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

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass: [Question class]]) {
        Question *other = (Question *)object;
        return (self.questionID == other.questionID);
    } else {
        return [super isEqual: object];
    }
}
@end
