//
//  StackOverflowManager.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 14/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManagerDelegate.h"

@class StackOverflowCommunicator;
@class QuestionBuilder;
@class AnswerBuilder;
@class Question;
@class Topic;
/**
 * A façade providing access to the Stack Overflow service.
 * Application code should only use this class to get at Stack Overflow innards.
 */
@interface StackOverflowManager : NSObject {
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
 * Signal from the communicator that fetching questions has failed.
 * @param error The error received from the network or server.
 */
- (void)searchingForQuestionsFailedWithError: (NSError *)error;

/**
 * The communicator received a response from the Stack Overflow search.
 */
- (void)receivedQuestionsJSON: (NSString *)objectNotation;

/**
 * Signal from the communicator that it couldn't retrieve a question body.
 */
- (void)fetchingQuestionBodyFailedWithError: (NSError *)error;

/**
 * The communicator received data with more details on a question.
 */
- (void)receivedQuestionBodyJSON: (NSString *)objectNotation;

/**
 * Get the answers to a question on Stack Overflow.
 * @note The delegate will receive messages when answers arrive or errors occur.
 * @param question The question for which to retrieve answers.
 * @see StackOverflowManagerDelegate
 */
- (void)fetchAnswersForQuestion: (Question *)question;

/**
 * Trying to retrieve answers failed.
 * @param error The error that caused the failure.
 */
- (void)fetchingAnswersFailedWithError: (NSError *)error;

/**
 * Data corresponding to answers was received by the communicator.
 * @param objectNotation The content returned by the server.
 */
- (void)receivedAnswerListJSON: (NSString *)objectNotation;

@end

extern NSString *StackOverflowManagerError;

enum {
    StackOverflowManagerErrorQuestionSearchCode,
    StackOverflowManagerErrorQuestionBodyFetchCode,
    StackOverflowManagerErrorAnswerFetchCode
};
