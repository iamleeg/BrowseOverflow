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
#import "AnswerCell.h"
#import "AvatarStore.h"
#import "AvatarStore+TestingExtensions.h"

@implementation QuestionDetailDataSourceTests
{
    QuestionDetailDataSource *dataSource;
    Question *question;
    Answer *answer1, *answer2;
    Person *asker;
    NSIndexPath *questionPath, *firstAnswerPath;
    AvatarStore *store;
}

- (void)setUp {
    dataSource = [[QuestionDetailDataSource alloc] init];
    question = [[Question alloc] init];
    question.title = @"Is this a dagger which I see before me, the handle toward my hand?";
    question.score = 2;
    question.body = @"<p>Come, let me clutch thee. I have thee not, and yet I see thee still. Art thou not, fatal vision, sensible to feeling as to sight?</p>";
    /*note - answer1.score < answer2.score, but answer1 is accepted so should
     *still be first in the list of answers.
     */
    answer1 = [[Answer alloc] init];
    answer1.score = 3;
    answer1.accepted = YES;
    answer2 = [[Answer alloc] init];
    answer2.score = 4;
    answer2.accepted = NO;
    [question addAnswer: answer1];
    [question addAnswer: answer2];
    asker = [[Person alloc] initWithName: @"Graham Lee" avatarLocation: @"http://www.gravatar.com/avatar/563290c0c1b776a315b36e863b388a0c"];
    question.asker = asker;
    dataSource.question = question;
    questionPath = [NSIndexPath indexPathForRow: 0 inSection: 0];
    firstAnswerPath = [NSIndexPath indexPathForRow: 0 inSection: 1];
    store = [[AvatarStore alloc] init];
}

- (void)tearDown {
    dataSource = nil;
    question = nil;
    asker = nil;
    answer1 = nil;
    answer2 = nil;
    store = nil;
    questionPath = nil;
    firstAnswerPath = nil;
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
    [[NSRunLoop currentRunLoop] runUntilDate: [NSDate dateWithTimeIntervalSinceNow: 0.5]];
    NSString *bodyHTML = [bodyView stringByEvaluatingJavaScriptFromString: @"document.body.innerHTML"];
    STAssertEqualObjects(bodyHTML, question.body, @"Question body should be used for the cell's web view");
    STAssertEqualObjects(cell.titleLabel.text, question.title, @"Question title used as cell title");
    STAssertEquals([cell.scoreLabel.text integerValue], question.score, @"Question's score should be displayed");
    STAssertEqualObjects(cell.nameLabel.text, asker.name, @"Person's name should be displayed");
}

- (void)testQuestionCellGetsImageFromAvatarStore {
    dataSource.avatarStore = store;
    NSURL *imageURL = [[NSBundle bundleForClass: [self class]] URLForResource: @"Graham_Lee" withExtension: @"jpg"];
    NSData *imageData = [NSData dataWithContentsOfURL: imageURL];
    [store setData: imageData forLocation: @"http://www.gravatar.com/avatar/563290c0c1b776a315b36e863b388a0c"];
    QuestionDetailCell *cell = (QuestionDetailCell *)[dataSource tableView: nil cellForRowAtIndexPath: questionPath];
    STAssertNotNil(cell.avatarView.image, @"The avatar store should supply the avatar images");
}

- (void)testAnswerPropertiesAppearInAnswerCell {
    AnswerCell *answerCell = (AnswerCell *)[dataSource tableView: nil cellForRowAtIndexPath: firstAnswerPath];
    STAssertEqualObjects(answerCell.scoreLabel.text, @"3", @"Score from the first answer should appear in the score label");
}
@end
