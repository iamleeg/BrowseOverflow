//
//  TopicTests.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 17/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "TopicTests.h"
#import "Topic.h"

@implementation TopicTests

- (void)testThatTopicExists {
    Topic *newTopic = [[Topic alloc] initWithName: @"iPhone" tag: @"iphone"];
    STAssertNotNil(newTopic, @"should be able to create a Topic instance");
    [newTopic release];
}

- (void)testThatTopicCanBeNamed {
    Topic *namedTopic = [[Topic alloc] initWithName: @"iPhone" tag: @"iphone"];
    STAssertEqualObjects(namedTopic.name, @"iPhone", @"the Topic should have the name I gave it");
    [namedTopic release];
}

- (void)testThatTopicHasATag {
    Topic *taggedTopic = [[Topic alloc] initWithName: @"iPhone" tag: @"iphone"];
    STAssertEqualObjects(taggedTopic.tag, @"iphone", @"");
    [taggedTopic release];
}

@end
