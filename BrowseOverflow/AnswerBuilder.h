//
//  AnswerBuilder.h
//  BrowseOverflow
//
//  Created by Graham Lee on 25/04/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

/**
 * Constructing Answer objects from data sent by the Stack Overflow site.
 * @see Answer
 */
@interface AnswerBuilder : NSObject {
    
}

/**
 * Populate a question object with the answers
 * supplied by the Stack Overflow web service.
 * @param question The question to which answers are required.
 * @param objectNotation The data containing the answer content.
 * @param error A by-reference error return.
 * @return YES if answers are successfully parsed, otherwise NO and error is filled to describe the problem.
 * @note If the data is valid but there are no answers to add, this is not an error.
 */
- (BOOL)addAnswersToQuestion: (Question *)question fromJSON: (NSString *)objectNotation error: (NSError **)error;

@end
