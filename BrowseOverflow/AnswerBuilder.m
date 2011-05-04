//
//  AnswerBuilder.m
//  BrowseOverflow
//
//  Created by Graham Lee on 25/04/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "AnswerBuilder.h"
#import "JSON.h"

@implementation AnswerBuilder

- (BOOL)addAnswersToQuestion: (Question *)question fromJSON: (NSString *)objectNotation error: (NSError **)error {
    NSParameterAssert(objectNotation != nil);
    NSParameterAssert(question != nil);
    NSDictionary *answerData = [objectNotation JSONValue];
    if (answerData == nil) {
        if (error) {
            *error = [NSError errorWithDomain: AnswerBuilderErrorDomain code: AnswerBuilderErrorInvalidJSONError userInfo: nil];
        }
        return NO;
    }
    
    NSArray *answers = [answerData objectForKey: @"answers"];
    if (answers == nil) {
        if (error) {
            *error = [NSError errorWithDomain: AnswerBuilderErrorDomain code:AnswerBuilderErrorMissingDataError userInfo: nil];
        }
        return NO;
    }
    return YES;
}

@end

NSString *AnswerBuilderErrorDomain = @"AnswerBuilderErrorDomain";