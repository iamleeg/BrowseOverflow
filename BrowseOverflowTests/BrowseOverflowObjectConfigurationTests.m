//
//  BrowseOverflowObjectConfigurationTests.m
//  BrowseOverflow
//
//  Created by Graham Lee on 01/11/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "BrowseOverflowObjectConfigurationTests.h"
#import "BrowseOverflowObjectConfiguration.h"
#import "StackOverflowManager.h"
#import "StackOverflowCommunicator.h"

#import <UIKit/UIKit.h>

@implementation BrowseOverflowObjectConfigurationTests

- (void)testConfigurationOfCreatedStackOverflowManager {
    BrowseOverflowObjectConfiguration *configuration = [[BrowseOverflowObjectConfiguration alloc] init];
    StackOverflowManager *manager = [configuration stackOverflowManager];
    STAssertNotNil(manager, @"The StackOverflowManager should exist");
    STAssertNotNil(manager.communicator, @"Manager should have a StackOverflowCommunicator");
    STAssertNotNil(manager.questionBuilder, @"Manager should have a question builder");
    STAssertNotNil(manager.answerBuilder, @"Manager should have an answer builder");
    STAssertEqualObjects(manager.communicator.delegate, manager, @"The manager is the communicator's delegate");
}

@end
