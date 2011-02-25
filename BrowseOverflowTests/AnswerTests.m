//
//  AnswerTests.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 25/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "AnswerTests.h"
#import "Answer.h"

@implementation AnswerTests

- (void)testAnswerHasSomeText {
    Answer *answer = [[Answer alloc] init];
    answer.text = @"The answer is 42";
    STAssertEqualObjects(answer.text, @"The answer is 42", @"Answers need to contain some text");
    [answer release];
}

@end
