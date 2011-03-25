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

- (void)fetchingQuestionsOnTopic: (Topic *)topic failedWithError: (NSError *)error;

@end
