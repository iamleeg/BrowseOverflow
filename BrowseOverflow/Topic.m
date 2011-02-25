//
//  Topic.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 17/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "Topic.h"
#import "Question.h"

@implementation Topic
@synthesize name;
@synthesize tag;

- (id)initWithName:(NSString *)newName tag: (NSString *)newTag {
    if ((self = [super init])) {
        name = [newName copy];
        tag = [newTag copy];
        questions = [[NSArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    [name release];
    [tag release];
    [questions release];
    [super dealloc];
}

- (void)addQuestion: (Question *)question {
    NSArray *newQuestions = [questions arrayByAddingObject: question];
    [questions release];
    questions = [newQuestions retain];
}

- (NSArray *)recentQuestions {
    return [questions sortedArrayUsingComparator: ^(id obj1, id obj2) {
        Question *q1 = (Question *)obj1;
        Question *q2 = (Question *)obj2;
        NSComparisonResult sortOrder = [q1.askedDate compare: q2.askedDate];
        switch (sortOrder) {
            case NSOrderedAscending:
                return NSOrderedDescending;
            case NSOrderedDescending:
                return NSOrderedAscending;
            default:
                return NSOrderedSame;
        }
    }];
}

@end
