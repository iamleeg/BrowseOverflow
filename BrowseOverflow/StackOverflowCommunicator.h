//
//  StackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 17/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicatorDelegate.h"

@interface StackOverflowCommunicator : NSObject <NSURLConnectionDataDelegate> {
@protected
    NSURL *fetchingURL;
    NSURLConnection *fetchingConnection;
    NSMutableData *receivedData;
@private
    id <StackOverflowCommunicatorDelegate> __weak delegate;
    void (^errorHandler)(NSError *);
    void (^successHandler)(NSString *);
}

@property (weak) id <StackOverflowCommunicatorDelegate> delegate;

- (void)searchForQuestionsWithTag: (NSString *)tag;
- (void)downloadInformationForQuestionWithID: (NSInteger)identifier;
- (void)downloadAnswersToQuestionWithID: (NSInteger)identifier;

- (void)cancelAndDiscardURLConnection;
@end

extern NSString *StackOverflowCommunicatorErrorDomain;
