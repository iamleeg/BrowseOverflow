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

- (void)dealloc {
    [url release];
    [receivedData release];
    [super dealloc];
}

- (void)fetchDataForURL:(NSURL *)location {
    self.url = location;
    NSURLRequest *request = [NSURLRequest requestWithURL: location];
    self.connection = [NSURLConnection connectionWithRequest: request delegate: self];
}

#pragma mark NSURLConnection Delegate

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [delegate communicatorReceivedData: [[receivedData copy] autorelease] forURL: url];
}

@end
