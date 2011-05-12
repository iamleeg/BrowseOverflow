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

@end

@implementation StackOverflowCommunicator

- (void)fetchContentAtURL:(NSURL *)url {
    [url retain];
    [fetchingURL release];
    fetchingURL = url;
    
    NSURLRequest *request = [NSURLRequest requestWithURL: fetchingURL];
    
    [self cancelAndDiscardURLConnection];
    fetchingConnection = [NSURLConnection connectionWithRequest: request delegate: self];
    
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
    [super dealloc];
}

- (void)cancelAndDiscardURLConnection {
    [fetchingConnection cancel];
    fetchingConnection = nil;
}
@end
