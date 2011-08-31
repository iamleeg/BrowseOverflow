//
//  QuestionDetailDataSourceTests.m
//  BrowseOverflow
//
//  Created by Graham Lee on 30/08/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "QuestionDetailDataSourceTests.h"
#import "QuestionDetailDataSource.h"
#import "QuestionDetailCell.h"
#import "Question.h"
#import "Person.h"
#import "Answer.h"

@implementation QuestionDetailDataSourceTests
{
    QuestionDetailDataSource *dataSource;
    Question *question;
    Answer *answer1, *answer2;
    NSIndexPath *questionPath;
}

- (void)setUp {
    dataSource = [[QuestionDetailDataSource alloc] init];
    question = [[Question alloc] init];
    question.title = @"Is this a dagger which I see before me, the handle toward my hand?";
    question.score = 2;
    question.body = @"<p>Come, let me clutch thee. I have thee not, and yet I see thee still. Art thou not, fatal vision, sensible to feeling as to sight?</p>";
    answer1 = [[Answer alloc] init];
    answer2 = [[Answer alloc] init];
    [question addAnswer: answer1];
    [question addAnswer: answer2];
    dataSource.question = question;
    questionPath = [NSIndexPath indexPathForRow: 0 inSection: 0];
}

- (void)tearDown {
    dataSource = nil;
    question = nil;
    answer1 = nil;
    answer2 = nil;
}

- (void)testTwoSectionsInTheTableView {
    STAssertEquals([dataSource numberOfSectionsInTableView: nil], (NSInteger)2, @"Always two sections in the table view");
}

- (void)testOneRowInTheFirstSection {
    STAssertEquals([dataSource tableView: nil numberOfRowsInSection: 0], (NSInteger)1, @"Always one row in section 0");
}

- (void)testOneRowPerAnswerInTheSecondSection {
    STAssertEquals([dataSource tableView: nil numberOfRowsInSection: 1], (NSInteger)2, @"One row per answer in section 1");
}

- (void)testQuestionPropertiesAppearInQuestionCell {
    QuestionDetailCell *cell = (QuestionDetailCell *)[dataSource tableView: nil cellForRowAtIndexPath: questionPath];
    UIWebView *bodyView = cell.bodyWebView;
    /* NASTY HACK ALERT
     * The UIWebView loads its contents asynchronously. If it's still doing
     * that when the test comes to evaluate its content, the content will seem
     * empty and the test will fail. Any solution to this comes down to "hold
     * the test back for a bit", which I've done explicitly here.
     * http://stackoverflow.com/questions/7255515/why-is-my-uiwebview-empty-in-my-unit-test
     */
    [[NSRunLoop currentRunLoop] runUntilDate: [NSDate dateWithTimeIntervalSinceNow: 0.25]];
    NSString *bodyHTML = [bodyView stringByEvaluatingJavaScriptFromString: @"document.body.innerHTML"];
    STAssertEqualObjects(bodyHTML, question.body, @"Question body should be used for the cell's web view");
}
@end
