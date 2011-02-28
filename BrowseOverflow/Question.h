//
//  Question.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 21/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Answer;

/**
 * Represents a question asked on the Stack Overflow website.
 */
@interface Question : NSObject {
    NSMutableSet *answerSet;
}

/**
 * The date on which the question was asked.
 */
@property (retain) NSDate *date;
@property (copy) NSString *title;
@property NSInteger score;
@property (readonly) NSArray *answers;

- (void)addAnswer: (Answer *)answer;

@end
