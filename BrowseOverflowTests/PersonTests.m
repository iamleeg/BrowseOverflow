//
//  PersonTests.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 24/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "PersonTests.h"
#import "Person.h"

@implementation PersonTests

- (void)setUp {
    person = [[Person alloc] initWithName: @"Graham Lee"
                                   avatarLocation: @"http://example.com/avatar.png"];
}

- (void)testThatPersonHasTheRightName {
    XCTAssertEqualObjects(person.name, @"Graham Lee", @"expecting a person to provide its name");
}

- (void)testThatPersonHasAnAvatarURL {
    NSURL *url = person.avatarURL;
    XCTAssertEqualObjects([url absoluteString], @"http://example.com/avatar.png", @"The Person's avatar should be represented by a URL");
}

@end
