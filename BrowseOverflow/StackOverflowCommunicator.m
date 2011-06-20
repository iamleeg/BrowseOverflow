//
//  StackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 17/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface StackOverflowCommunicator ()

- (void)fetchContentAtURL: (NSURL *)url errorHandler: (void(^)(NSError *error))errorBlock successHandler: (void(^)(NSString *objectNotation)) successBlock;
- (void)launchConnectionForRequest: (NSURLRequest *)request;

@end

@implementation StackOverflowCommunicator

@synthesize delegate;

- (void)launchConnectionForRequest: (NSURLRequest *)request  {
  [self cancelAndDiscardURLConnection];
    fetchingConnection = [NSURLConnection connectionWithRequest: request delegate: self];

}
- (void)fetchContentAtURL:(NSURL *)url errorHandler:(void (^)(NSError *))errorBlock successHandler:(void (^)(NSString *))successBlock {
    [url retain];
    [fetchingURL release];
    fetchingURL = url;
    [errorHandler release];
    errorHandler = [errorBlock copy];
    [successHandler release];
    successHandler = [successBlock copy];
    NSURLRequest *request = [NSURLRequest requestWithURL: fetchingURL];
    
    [self launchConnectionForRequest: request];

    
}

- (void)searchForQuestionsWithTag:(NSString *)tag {
    [self fetchContentAtURL: [NSURL URLWithString:
                              [NSString stringWithFormat: @"http://api.stackoverflow.com/1.1/search?tagged=%@&pagesize=20", tag]]
               errorHandler: ^(NSError *error) {
                   [delegate searchingForQuestionsFailedWithError: error];
               }
             successHandler: ^(NSString *objectNotation) {
                 [delegate receivedQuestionsJSON: objectNotation];
             }];
}

- (void)downloadInformationForQuestionWithID:(NSInteger)identifier {
    [self fetchContentAtURL: [NSURL URLWithString:
                              [NSString stringWithFormat: @"http://api.stackoverflow.com/1.1/questions/%d?body=true", identifier]]
               errorHandler: ^(NSError *error) {
                   [delegate fetchingQuestionBodyFailedWithError: error];
               }
             successHandler: ^(NSString *objectNotation) {
                 [delegate receivedQuestionBodyJSON: objectNotation];
             }];
}

- (void)downloadAnswersToQuestionWithID:(NSInteger)identifier {
    [self fetchContentAtURL: [NSURL URLWithString:
                              [NSString stringWithFormat: @"http://api.stackoverflow.com/1.1/questions/%d/answers?body=true", identifier]]
               errorHandler: ^(NSError *error) {
                   [delegate fetchingAnswersFailedWithError: error];
               }
             successHandler: ^(NSString *objectNotation) {
                 [delegate receivedAnswerListJSON: objectNotation];
             }];
}

- (void)dealloc {
    [errorHandler release];
    [successHandler release];
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
        [self cancelAndDiscardURLConnection];
    }
    else {
        receivedData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [receivedData release];
    receivedData = nil;
    fetchingConnection = nil;
    [fetchingURL release];
    fetchingURL = nil;
    errorHandler(error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    fetchingConnection = nil;
    [fetchingURL release];
    fetchingURL = nil;
    NSString *receivedText = [[NSString alloc] initWithData: receivedData
                                                   encoding: NSUTF8StringEncoding];
    [receivedData release];
    receivedData = nil;
    successHandler(receivedText);
    [receivedText release];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData: data];
}

@end

NSString *StackOverflowCommunicatorErrorDomain = @"StackOverflowCommunicatorErrorDomain";
