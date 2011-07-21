//
//  GravatarCommunicator.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 26/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "GravatarCommunicator.h"


@implementation GravatarCommunicator

@synthesize url;
@synthesize delegate;
@synthesize receivedData;
@synthesize connection;


- (void)fetchDataForURL:(NSURL *)location {
    self.url = location;
    NSURLRequest *request = [NSURLRequest requestWithURL: location];
    self.connection = [NSURLConnection connectionWithRequest: request delegate: self];
}

#pragma mark NSURLConnection Delegate

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [delegate communicatorReceivedData: [receivedData copy] forURL: url];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.receivedData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData: data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [delegate communicatorGotErrorForURL: url];
}

@end
