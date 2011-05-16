//
//  StackOverflowManager.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 14/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManagerDelegate.h"
#import "StackOverflowCommunicatorDelegate.h"

@class StackOverflowCommunicator;
@class QuestionBuilder;
@class AnswerBuilder;
@class Question;
@class Topic;
/**
 * A façade providing access to the Stack Overflow service.
 * Application code should only use this class to get at Stack Overflow innards.
 */
@interface StackOverflowManager : NSObject <StackOverflowCommunicatorDelegate> {
    id <StackOverflowManagerDelegate> delegate;
}
@property (assign) id <StackOverflowManagerDelegate> delegate;
@property (retain) StackOverflowCommunicator *communicator;
@property (retain) QuestionBuilder *questionBuilder;
@property (retain) AnswerBuilder *answerBuilder;
@property (retain) Question *questionToFill;
/**
 * Retrieve questions on a given topic from Stack Overflow.
 * @note The delegate will receive messages when new information
 *       arrives, and this class will ask the delegate if it needs
 *       guidance.
 * @param topic The subject on which to find questions.
 * @see StackOverflowManagerDelegate
 */
- (void)fetchQuestionsOnTopic: (Topic *)topic;

/**
 * Get the body for a question from Stack Overflow.
 * @note The delegate will receive messages when new information arrives.
 * @param question The question for which to get the body.
 * @see StackOverflowManagerDelegate
 */
- (void)fetchBodyForQuestion: (Question *)question;

/**
 * Get the answers to a question on Stack Overflow.
 * @note The delegate will receive messages when answers arrive or errors occur.
 * @param question The question for which to retrieve answers.
 * @see StackOverflowManagerDelegate
 */
- (void)fetchAnswersForQuestion: (Question *)question;

@end

extern NSString *StackOverflowManagerError;

enum {
    StackOverflowManagerErrorQuestionSearchCode,
    StackOverflowManagerErrorQuestionBodyFetchCode,
    StackOverflowManagerErrorAnswerFetchCode
};
