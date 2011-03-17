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

/**
 * Retrieve questions on a given topic from Stack Overflow.
 * @note The delegate will receive messages when new information
 *       arrives, and will ask the delegate if it needs guidance.
 * @param topic The subject on which to find questions.
 * @see StackOverflowManagerDelegate
 */
- (void)fetchQuestionsOnTopic: (Topic *)topic;

@end
