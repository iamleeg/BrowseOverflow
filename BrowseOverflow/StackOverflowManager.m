//
//  StackOverflowManager.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 14/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "StackOverflowManager.h"
#import "StackOverflowCommunicator.h"
#import "QuestionBuilder.h"
#import "Topic.h"

@interface StackOverflowManager ()

- (void)tellDelegateAboutQuestionSearchError: (NSError *)underlyingError;

@end

@implementation StackOverflowManager

@synthesize communicator;
@synthesize questionBuilder;

- (id<StackOverflowManagerDelegate>)delegate {
    return delegate;
}

- (void)setDelegate:(id<StackOverflowManagerDelegate>)newDelegate {
    if (![newDelegate conformsToProtocol: @protocol(StackOverflowManagerDelegate)]) {
        [[NSException exceptionWithName: NSInvalidArgumentException reason: @"Delegate object does not conform to the delegate protocol" userInfo: nil] raise];
    }
    delegate = newDelegate;
}

- (void)fetchQuestionsOnTopic:(Topic *)topic {
    [communicator searchForQuestionsWithTag: [topic tag]];
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation {
    NSError *error = nil;
    NSArray *questions = [questionBuilder questionsFromJSON: objectNotation error: &error];
    if (!questions) {
        [self tellDelegateAboutQuestionSearchError: error];
    }
}

- (void)searchingForQuestionsFailedWithError:(NSError *)error {
    [self tellDelegateAboutQuestionSearchError: error];
}

- (void)dealloc {
    [communicator release];
    [super dealloc];
}

#pragma mark Class Continuation
- (void)tellDelegateAboutQuestionSearchError:(NSError *)underlyingError {
    NSDictionary *errorInfo = nil;
    if (underlyingError) {
        errorInfo = [NSDictionary dictionaryWithObject: underlyingError forKey: NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain: StackOverflowManagerSearchFailedError code: StackOverflowManagerErrorQuestionSearchCode userInfo: errorInfo];
    [delegate fetchingQuestionsFailedWithError:reportableError];
}

@end

NSString *StackOverflowManagerSearchFailedError = @"StackOverflowManagerSearchFailedError";
