//
//  StackOverflowManagerDelegate.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 14/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Topic;
/**
 * The delegate protocol for the StackOverflowManager class.
 *
 * StackOverflowManager uses this delegate protocol to indicate when information becomes available, and to ask about doing further processing.
 */
@protocol StackOverflowManagerDelegate <NSObject>

/**
 * The manager was unable to retrieve questions from Stack Overflow.
 */
- (void)fetchingQuestionsFailedWithError: (NSError *)error;

/**
 * The manager retrieved a list of questions from Stack Overflow.
 */
- (void)questionsReceived: (NSArray *)questions;

/**
 * The manager couldn't fetch a question body.
 */
- (void)fetchingQuestionBodyFailedWithError: (NSError *)error;

@end
