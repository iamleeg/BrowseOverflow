//
//  InspectableStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 11/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "InspectableStackOverflowCommunicator.h"


@implementation InspectableStackOverflowCommunicator

- (NSURL *)URLToFetch {
    return fetchingURL;
}

- (NSURLConnection *)currentURLConnection {
    return fetchingConnection;
}


@end
