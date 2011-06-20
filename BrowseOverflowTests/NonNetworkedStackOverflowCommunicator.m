//
//  NonNetworkedStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 12/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "NonNetworkedStackOverflowCommunicator.h"


@implementation NonNetworkedStackOverflowCommunicator

- (void)launchConnectionForRequest: (NSURLRequest *)request {
    
}

- (void)setReceivedData:(NSData *)data {
    receivedData = [data mutableCopy];
}

- (NSData *)receivedData {
    return [[receivedData copy] autorelease];
}

@end
