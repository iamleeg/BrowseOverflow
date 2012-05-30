//
//  Topic.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 17/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "Topic.h"
#import "Question.h"

@interface Topic ()

- (NSArray *)sortQuestionsLatestFirst: (NSArray *)questionList;

@end

@implementation Topic
{
    NSSet *questions;
}
@synthesize name;
@synthesize tag;

- (id)initWithName:(NSString *)newName tag: (NSString *)newTag {
    if ((self = [super init])) {
        name = [newName copy];
        tag = [newTag copy];
        questions = [[NSSet alloc] init];
    }
    return self;
}


- (void)addQuestion: (Question *)question {
    NSSet *newQuestions = [questions setByAddingObject: question];
    NSArray *latestQuestions = [newQuestions allObjects];
    if ([newQuestions count] > 20) {
        latestQuestions = [self sortQuestionsLatestFirst: latestQuestions];
        latestQuestions = [latestQuestions subarrayWithRange: NSMakeRange(0, 20)];
    }
    questions = [NSSet setWithArray: latestQuestions];
}

- (NSArray *)recentQuestions {
    return [self sortQuestionsLatestFirst: [questions allObjects]];
}

- (NSArray *)sortQuestionsLatestFirst: (NSArray *)questionList {
    return [questionList sortedArrayUsingComparator: ^(id obj1, id obj2) {
        Question *q1 = (Question *)obj1;
        Question *q2 = (Question *)obj2;
        NSComparisonResult sortOrder = [q1.date compare: q2.date];
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
