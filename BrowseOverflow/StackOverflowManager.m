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
#import "Question.h"
#import "Topic.h"

@interface StackOverflowManager ()

- (void)tellDelegateAboutQuestionSearchError: (NSError *)underlyingError;

@end

@implementation StackOverflowManager

@synthesize communicator;
@synthesize questionBuilder;
@synthesize questionToFill;

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

- (void)fetchBodyForQuestion:(Question *)question {
    self.questionToFill = question;
    [communicator downloadInformationForQuestionWithID: question.questionID];
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation {
    NSError *error = nil;
    NSArray *questions = [questionBuilder questionsFromJSON: objectNotation error: &error];
    if (!questions) {
        [self tellDelegateAboutQuestionSearchError: error];
    }
    else {
        [delegate questionsReceived: questions];
    }
}

- (void)receivedQuestionBodyJSON:(NSString *)objectNotation {
    [questionBuilder fillInDetailsForQuestion: self.questionToFill fromJSON: objectNotation];
    self.questionToFill = nil;
}

- (void)searchingForQuestionsFailedWithError:(NSError *)error {
    self.questionToFill = nil;
    [self tellDelegateAboutQuestionSearchError: error];
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error {
    NSDictionary *errorInfo = nil;
    if (error) {
        errorInfo = [NSDictionary dictionaryWithObject: error forKey: NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain: StackOverflowManagerError code: StackOverflowManagerErrorQuestionBodyFetchCode userInfo:errorInfo];
    [delegate fetchingQuestionBodyFailedWithError: reportableError];
}

- (void)dealloc {
    [communicator release];
    [questionToFill release];
    [super dealloc];
}

#pragma mark Class Continuation
- (void)tellDelegateAboutQuestionSearchError:(NSError *)underlyingError {
    NSDictionary *errorInfo = nil;
    if (underlyingError) {
        errorInfo = [NSDictionary dictionaryWithObject: underlyingError forKey: NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain: StackOverflowManagerError code: StackOverflowManagerErrorQuestionSearchCode userInfo: errorInfo];
    [delegate fetchingQuestionsFailedWithError:reportableError];
}

@end

NSString *StackOverflowManagerError = @"StackOverflowManagerError";
