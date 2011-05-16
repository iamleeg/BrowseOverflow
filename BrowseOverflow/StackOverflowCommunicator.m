//
//  StackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 17/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface StackOverflowCommunicator ()

- (void)fetchContentAtURL: (NSURL *)url errorHandler: (void(^)(NSError *error))errorBlock;
- (void)launchConnectionForRequest: (NSURLRequest *)request;

@end

@implementation StackOverflowCommunicator

@synthesize delegate;

- (void)launchConnectionForRequest: (NSURLRequest *)request  {
  [self cancelAndDiscardURLConnection];
    fetchingConnection = [NSURLConnection connectionWithRequest: request delegate: self];

}
- (void)fetchContentAtURL:(NSURL *)url errorHandler:(void (^)(NSError *))errorBlock {
    [url retain];
    [fetchingURL release];
    fetchingURL = url;
    [errorHandler release];
    errorHandler = [errorBlock copy];
    NSURLRequest *request = [NSURLRequest requestWithURL: fetchingURL];
    
    [self launchConnectionForRequest: request];

    
}

- (void)searchForQuestionsWithTag:(NSString *)tag {
    [self fetchContentAtURL: [NSURL URLWithString:
                              [NSString stringWithFormat: @"http://api.stackoverflow.com/1.1/search?tagged=%@&pagesize=20", tag]]
               errorHandler: ^(NSError *error) {
                   [delegate searchingForQuestionsFailedWithError: error];
               }];
}

- (void)downloadInformationForQuestionWithID:(NSInteger)identifier {
    [self fetchContentAtURL: [NSURL URLWithString:
                              [NSString stringWithFormat: @"http://api.stackoverflow.com/1.1/questions/%d?body=true", identifier]]
               errorHandler: ^(NSError *error) {
                   [delegate fetchingQuestionBodyFailedWithError: error];
               }];
}

- (void)downloadAnswersToQuestionWithID:(NSInteger)identifier {
    [self fetchContentAtURL: [NSURL URLWithString:
                              [NSString stringWithFormat: @"http://api.stackoverflow.com/1.1/questions/%d/answers?body=true", identifier]]
               errorHandler: ^(NSError *error) {
                   [delegate fetchingAnswersFailedWithError: error];
               }];
}

- (void)dealloc {
    [errorHandler release];
    [fetchingURL release];
    [fetchingConnection cancel];
    [receivedData release];
    [super dealloc];
}

- (void)cancelAndDiscardURLConnection {
    [fetchingConnection cancel];
    fetchingConnection = nil;
}

#pragma mark NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receivedData release];
    receivedData = nil;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ([httpResponse statusCode] != 200) {
        NSError *error = [NSError errorWithDomain: StackOverflowCommunicatorErrorDomain code: [httpResponse statusCode] userInfo: nil];
        errorHandler(error);
    }
    else {
        receivedData = [[NSMutableData alloc] init];
    }
}

@end

NSString *StackOverflowCommunicatorErrorDomain = @"StackOverflowCommunicatorErrorDomain";
