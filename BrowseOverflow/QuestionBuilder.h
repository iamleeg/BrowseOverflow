//
//  QuestionBuilder.h
//  BrowseOverflow
//
//  Created by Graham Lee on 30/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Construct Question objects from an external representation.
 * @see Question
 */
@interface QuestionBuilder : NSObject {
    
}
/**
 * Given a string containing a JSON dictionary, return a list of Question objects.
 * @note The format of the JSON is driven by the Stack Exchange 1.1 API.
 * @param objectNotation The JSON string
 * @param error By-ref error signalling
 * @return An array of Question objects, or nil (with error set) if objectNotation cannot be parsed.
 * @see Question
 */
- (NSArray *)questionsFromJSON: (NSString *)objectNotation error: (NSError **)error;

@end

extern NSString *QuestionBuilderErrorDomain;

enum {
    QuestionBuilderInvalidJSONError,
    QuestionBuilderMissingDataError,
};