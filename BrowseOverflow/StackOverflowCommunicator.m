//
//  StackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 17/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@interface StackOverflowCommunicator ()

- (void)fetchContentAtURL: (NSURL *)url;
- (void)launchConnectionForRequest: (NSURLRequest *)request;

@end

@implementation StackOverflowCommunicator

- (void)launchConnectionForRequest: (NSURLRequest *)request  {
  [self cancelAndDiscardURLConnection];
    fetchingConnection = [NSURLConnection connectionWithRequest: request delegate: self];

}
- (void)fetchContentAtURL:(NSURL *)url {
    [url retain];
    [fetchingURL release];
    fetchingURL = url;
    
    NSURLRequest *request = [NSURLRequest requestWithURL: fetchingURL];
    
    [self launchConnectionForRequest: request];

    
}

- (void)searchForQuestionsWithTag:(NSString *)tag {
    [self fetchContentAtURL: [NSURL URLWithString:
                              [NSString stringWithFormat: @"http://api.stackoverflow.com/1.1/search?tagged=%@&pagesize=20", tag]]];
}

- (void)downloadInformationForQuestionWithID:(NSInteger)identifier {
    [self fetchContentAtURL: [NSURL URLWithString:
                              [NSString stringWithFormat: @"http://api.stackoverflow.com/1.1/questions/%d?body=true", identifier]]];
}

- (void)downloadAnswersToQuestionWithID:(NSInteger)identifier {
    [self fetchContentAtURL: [NSURL URLWithString:
                              [NSString stringWithFormat: @"http://api.stackoverflow.com/1.1/questions/%d/answers?body=true", identifier]]];
}

- (void)dealloc {
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
    receivedData = [[NSMutableData alloc] init];
}

@end
