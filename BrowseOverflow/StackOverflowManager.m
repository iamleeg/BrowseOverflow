//
//  StackOverflowManager.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 14/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "StackOverflowManager.h"
#import "StackOverflowCommunicator.h"
#import "Topic.h"

@implementation StackOverflowManager

@synthesize communicator;

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

- (void)dealloc {
    [communicator release];
    [super dealloc];
}

@end
