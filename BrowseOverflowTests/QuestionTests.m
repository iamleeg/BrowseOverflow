//
//  QuestionTests.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 21/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "QuestionTests.h"
#import "Question.h"
#import "Answer.h"
#import "Person.h"

@implementation QuestionTests

- (void)setUp {
    question = [[Question alloc] init];
    question.date = [NSDate distantPast];
    question.title = @"Do iPhones also dream of electric sheep?";
    question.body = @"I'm just wondering whether they do the same things that Androids do.";
    question.score = 42;
    question.questionID = 17;
    
    Answer *accepted = [[Answer alloc] init];
    accepted.score = 1;
    accepted.accepted = YES;
    [question addAnswer: accepted];
    
    lowScore = [[Answer alloc] init];
    lowScore.score = -4;
    [question addAnswer: lowScore];
    
    highScore = [[Answer alloc] init];
    highScore.score = 4;
    [question addAnswer: highScore];
    
    asker = [[Person alloc] initWithName: @"Graham Lee" avatarLocation:@"http://example.com/avatar.png"];
    question.asker = asker;
    
}

- (void)testQuestionHasATitle {
    STAssertEqualObjects(question.title, @"Do iPhones also dream of electric sheep?", @"Question should know its title");
}

- (void)testQuestionHasABody {
    STAssertEqualObjects(question.body, @"I'm just wondering whether they do the same things that Androids do.", @"Question should have body content");
}

- (void)testQuestionHasADate {
    STAssertEqualObjects(question.date, [NSDate distantPast], @"Question needs to provide its date");
}

- (void)testQuestionKeepsScore {
    STAssertEquals(question.score, 42, @"Questions need a numeric score");
}

- (void)testQuestionCanHaveAnswersAdded {
    Answer *myAnswer = [[Answer alloc] init];
    STAssertNoThrow([question addAnswer: myAnswer], @"Must be able to add answers");
}

- (void)testAcceptedAnswerIsFirst {
    STAssertTrue([[question.answers objectAtIndex: 0] isAccepted], @"Accepted answer comes first");
}

- (void)testQuestionHasIdentity {
    STAssertEquals(question.questionID, 17, @"Questions need a numeric identifier");
}

- (void)testHighScoreAnswerBeforeLow {
    NSArray *answers = question.answers;
    NSInteger highIndex = [answers indexOfObject: highScore];
    NSInteger lowIndex = [answers indexOfObject: lowScore];
    STAssertTrue(highIndex < lowIndex, @"High-scoring answer comes first");
}

- (void)testQuestionWasAskedBySomeone {
    STAssertEqualObjects(question.asker, asker, @"Question should keep track of who asked it.");
}
@end
