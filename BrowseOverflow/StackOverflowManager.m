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
    NSArray *questions = [questionBuilder questionsFromJSON: objectNotation error: NULL];
}

- (void)searchingForQuestionsFailedWithError:(NSError *)error {
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObject: error forKey: NSUnderlyingErrorKey];
    NSError *reportableError = [NSError errorWithDomain: StackOverflowManagerSearchFailedError code: StackOverflowManagerErrorQuestionSearchCode userInfo:errorInfo];
    [delegate fetchingQuestionsFailedWithError: reportableError];
}

- (void)dealloc {
    [communicator release];
    [super dealloc];
}

@end

NSString *StackOverflowManagerSearchFailedError = @"StackOverflowManagerSearchFailedError";
