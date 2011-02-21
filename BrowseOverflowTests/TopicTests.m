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

- (void)setUp {
    topic = [[Topic alloc] initWithName: @"iPhone" tag: @"iphone"];
}

- (void)tearDown {
    [topic release];
    topic = nil;
}

- (void)testThatTopicExists {
    STAssertNotNil(topic, @"should be able to create a Topic instance");
}

- (void)testThatTopicCanBeNamed {
    STAssertEqualObjects(topic.name, @"iPhone", @"the Topic should have the name I gave it");
}

- (void)testThatTopicHasATag {
    STAssertEqualObjects(topic.tag, @"iphone", @"the Topic should have the tag I gave it");
}

- (void)testForAListOfQuestions {
    STAssertTrue([[topic recentQuestions] isKindOfClass: [NSArray class]], @"Topics should provide a list of recent questions");
}
@end
