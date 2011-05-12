//
//  InspectableStackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 11/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicator.h"

@interface InspectableStackOverflowCommunicator : StackOverflowCommunicator {
}

- (NSURL *)URLToFetch;
- (NSURLConnection *)currentURLConnection;
- (void)cancelAndDiscardURLConnection;

@end
