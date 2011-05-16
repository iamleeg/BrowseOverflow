//
//  AnswerBuilder.m
//  BrowseOverflow
//
//  Created by Graham Lee on 25/04/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "AnswerBuilder.h"
#import "JSON.h"
#import "Answer.h"
#import "Question.h"
#import "UserBuilder.h"

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
    
    for (NSDictionary *answerData in answers) {
        Answer *thisAnswer = [[Answer alloc] init];
        thisAnswer.text = [answerData objectForKey: @"body"];
        thisAnswer.accepted = [[answerData objectForKey: @"accepted"] boolValue];
        thisAnswer.score = [[answerData objectForKey: @"score"] integerValue];
        NSDictionary *ownerData = [answerData objectForKey: @"owner"];
        thisAnswer.person = [UserBuilder personFromDictionary: ownerData];
        [question addAnswer: thisAnswer];
        [thisAnswer release];
    }
    return YES;
}

@end

NSString *AnswerBuilderErrorDomain = @"AnswerBuilderErrorDomain";