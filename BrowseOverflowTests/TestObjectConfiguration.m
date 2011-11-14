//
//  TestObjectConfiguration.m
//  BrowseOverflow
//
//  Created by Graham Lee on 14/11/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "TestObjectConfiguration.h"

@implementation TestObjectConfiguration

@synthesize objectToReturn;

- (StackOverflowManager *)stackOverflowManager {
    return (StackOverflowManager *)self.objectToReturn;
}

@end
