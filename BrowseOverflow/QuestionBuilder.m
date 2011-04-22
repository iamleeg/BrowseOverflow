//
//  QuestionBuilder.m
//  BrowseOverflow
//
//  Created by Graham Lee on 30/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "QuestionBuilder.h"
#import "JSON.h"
#import "Question.h"
#import "Person.h"

@implementation QuestionBuilder

- (NSArray *)questionsFromJSON:(NSString *)objectNotation error:(NSError **)error {
    NSParameterAssert(objectNotation != nil);
    NSDictionary *parsedObject = [objectNotation JSONValue];
    if (parsedObject == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code: QuestionBuilderInvalidJSONError userInfo: nil];
        }
        return nil;
    }
    NSArray *questions = [parsedObject objectForKey: @"questions"];
    if (questions == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code: QuestionBuilderMissingDataError userInfo:nil];
        }
        return nil;
    }
    NSMutableArray *results = [NSMutableArray arrayWithCapacity: [questions count]];
    for (NSDictionary *parsedQuestion in questions) {
        Question *thisQuestion = [[Question alloc] init];
        thisQuestion.questionID = [[parsedQuestion objectForKey: @"question_id"] integerValue];
        thisQuestion.date = [NSDate dateWithTimeIntervalSince1970: [[parsedQuestion objectForKey: @"creation_date"] doubleValue]];
        thisQuestion.title = [parsedQuestion objectForKey: @"title"];
        thisQuestion.score = [[parsedQuestion objectForKey: @"score"] integerValue];
        NSDictionary *ownerValues = [parsedQuestion objectForKey: @"owner"];
        NSString *name = [ownerValues objectForKey: @"display_name"];
        NSString *avatarURL = [NSString stringWithFormat: @"http://www.gravatar.com/avatar/%@", [ownerValues objectForKey: @"email_hash"]];
        Person *asker = [[Person alloc] initWithName: name avatarLocation: avatarURL];
        thisQuestion.asker = asker;
        [asker release];
        [results addObject: thisQuestion];
        [thisQuestion release];
    }
    return [[results copy] autorelease];
}

- (void)fillInDetailsForQuestion:(Question *)question fromJSON:(NSString *)objectNotation {
    NSParameterAssert(question != nil);
    NSParameterAssert(objectNotation != nil);
}

@end

NSString *QuestionBuilderErrorDomain = @"QuestionBuilderErrorDomain";