//
//  QuestionBuilder.h
//  BrowseOverflow
//
//  Created by Graham Lee on 30/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

/**
 * Construct Question objects from an external representation.
 * @note The format of the JSON is driven by the Stack Exchange 1.1 API.
 * @see Question
 */
@interface QuestionBuilder : NSObject {
    
}
/**
 * Given a string containing a JSON dictionary, return a list of Question objects.
 * @param objectNotation The JSON string
 * @param error By-ref error signalling
 * @return An array of Question objects, or nil (with error set) if objectNotation cannot be parsed.
 * @see Question
 */
- (NSArray *)questionsFromJSON: (NSString *)objectNotation error: (NSError **)error;

/**
 * Add information to a Question object based on a JSON dictionary.
 * @param objectNotation The JSON string
 * @param question The question to fill in
 * @note Due to the design of the Stack Exchange API, it's possible for
 *       this method not to change the content of the Question object.
 *       This is not considered an error.
 * @see Question
 */
- (void)fillInDetailsForQuestion: (Question *)question fromJSON: (NSString *)objectNotation;

@end

extern NSString *QuestionBuilderErrorDomain;

enum {
    QuestionBuilderInvalidJSONError,
    QuestionBuilderMissingDataError,
};