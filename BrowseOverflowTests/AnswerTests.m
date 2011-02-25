//
//  AnswerTests.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 25/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "AnswerTests.h"
#import "Answer.h"
#import "Person.h"

@implementation AnswerTests

- (void)setUp {
    answer = [[Answer alloc] init];
    answer.text = @"The answer is 42";
    answer.person = [[[Person alloc] initWithName: @"Graham Lee" avatarLocation: @"http://example.com/avatar.png"] autorelease];
    answer.score = 42;
}

- (void)tearDown {
    [answer release];
}

- (void)testAnswerHasSomeText {
    STAssertEqualObjects(answer.text, @"The answer is 42", @"Answers need to contain some text");
}

- (void)testSomeoneProvidedTheAnswer {
    STAssertTrue([answer.person isKindOfClass: [Person class]], @"A Person gave this Answer");
}

- (void)testAnswersNotAcceptedByDefault {
    STAssertFalse(answer.accepted, @"Answer not accepted by default");
}

- (void)testAnswerCanBeAccepted {
    STAssertNoThrow(answer.accepted = YES, @"It is possible to accept an answer");
}

- (void)testAnswerHasAScore {
    STAssertTrue(answer.score == 42, @"Answer's score can be retrieved");
}
@end
