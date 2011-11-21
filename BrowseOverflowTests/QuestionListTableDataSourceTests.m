//
//  QuestionListTableDataSourceTests.m
//  BrowseOverflow
//
//  Created by Graham Lee on 11/08/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "QuestionListTableDataSourceTests.h"
#import "QuestionListTableDataSource.h"
#import "Topic.h"
#import "Question.h"
#import "Person.h"
#import "QuestionSummaryCell.h"
#import "AvatarStore.h"
#import "AvatarStore+TestingExtensions.h"
#import "FakeNotificationCenter.h"
#import "ReloadDataWatcher.h"

@implementation QuestionListTableDataSourceTests
{
    QuestionListTableDataSource *dataSource;
    Topic *iPhoneTopic;
    NSIndexPath *firstCell;
    Question *question1, *question2;
    Person *asker1;
    AvatarStore *store;
    NSNotification *receivedNotification;
}

- (void)didReceiveNotification: (NSNotification *)note {
    receivedNotification = note;
}

- (void)setUp {
    dataSource = [[QuestionListTableDataSource alloc] init];
    iPhoneTopic = [[Topic alloc] initWithName: @"iPhone" tag: @"iphone"];
    dataSource.topic = iPhoneTopic;
    firstCell = [NSIndexPath indexPathForRow: 0 inSection: 0];
    question1 = [[Question alloc] init];
    question1.title = @"Question One";
    question1.score = 2;
    question2 = [[Question alloc] init];
    question2.title = @"Question Two";
    
    asker1 = [[Person alloc] initWithName: @"Graham Lee" avatarLocation: @"http://www.gravatar.com/avatar/563290c0c1b776a315b36e863b388a0c"];
    question1.asker = asker1;
    store = [[AvatarStore alloc] init];
}

- (void)tearDown {
    dataSource = nil;
    iPhoneTopic = nil;
    firstCell = nil;
    question1 = nil;
    question2 = nil;
    asker1 = nil;
    store = nil;
    receivedNotification = nil;
}

- (void)testTopicWithNoQuestionsLeadsToOneRowInTheTable {
    STAssertEquals([dataSource tableView: nil numberOfRowsInSection: 0], (NSInteger)1, @"The table view needs a 'no data yet' placeholder cell");
}

- (void)testTopicWithQuestionsResultsInOneRowPerQuestionInTheTable {
    [iPhoneTopic addQuestion: question1];
    [iPhoneTopic addQuestion: question2];
    STAssertEquals([dataSource tableView: nil numberOfRowsInSection: 0], (NSInteger)2, @"Two questions in the topic means two rows in the table");
}

- (void)testContentOfPlaceholderCell {
    UITableViewCell *placeholderCell = [dataSource tableView: nil cellForRowAtIndexPath: firstCell];
    STAssertEqualObjects(placeholderCell.textLabel.text, @"There was a problem connecting to the network.", @"The placeholder cell ought to display a placeholder message");
}

- (void)testPlaceholderCellNotReturnedWhenQuestionsExist {
    [iPhoneTopic addQuestion: question1];
    UITableViewCell *cell = [dataSource tableView: nil cellForRowAtIndexPath: firstCell];
    STAssertFalse([cell.textLabel.text isEqualToString: @"There was a problem connecting to the network."], @"Placeholder should only be shown when there's no content");
}

- (void)testCellPropertiesAreTheSameAsTheQuestion {
    [iPhoneTopic addQuestion: question1];
    QuestionSummaryCell *cell = (QuestionSummaryCell *)[dataSource tableView: nil cellForRowAtIndexPath: firstCell];
    STAssertEqualObjects(cell.titleLabel.text, @"Question One", @"Question cells display the question's title");
    STAssertEqualObjects(cell.scoreLabel.text, @"2", @"Question cells display the question's score");
    STAssertEqualObjects(cell.nameLabel.text, @"Graham Lee", @"Question cells display the asker's name");
}

- (void)testCellGetsImageFromAvatarStore {
    dataSource.avatarStore = store;
    NSURL *imageURL = [[NSBundle bundleForClass: [self class]] URLForResource: @"Graham_Lee" withExtension: @"jpg"];
    NSData *imageData = [NSData dataWithContentsOfURL: imageURL];
    [store setData: imageData forLocation: @"http://www.gravatar.com/avatar/563290c0c1b776a315b36e863b388a0c"];
    [iPhoneTopic addQuestion: question1];
    QuestionSummaryCell *cell = (QuestionSummaryCell *)[dataSource tableView: nil cellForRowAtIndexPath: firstCell];
    STAssertNotNil(cell.avatarView.image, @"The avatar store should supply the avatar images");
}

- (void)testQuestionListRegistersForAvatarNotifications {
    FakeNotificationCenter *center = [[FakeNotificationCenter alloc] init];
    dataSource.notificationCenter = (NSNotificationCenter *)center;
    [dataSource registerForUpdatesToAvatarStore: store];
    STAssertTrue([center hasObject: dataSource forNotification: AvatarStoreDidUpdateContentNotification], @"The data source should know when new images have been downloaded");
}

- (void)testQuestionListStopsRegisteringForAvatarNotifications {
    FakeNotificationCenter *center = [[FakeNotificationCenter alloc] init];
    dataSource.notificationCenter = (NSNotificationCenter *)center;
    [dataSource registerForUpdatesToAvatarStore: store];
    [dataSource removeObservationOfUpdatesToAvatarStore: store];
    STAssertFalse([center hasObject: dataSource forNotification: AvatarStoreDidUpdateContentNotification], @"The data source  should no longer listen to avatar store notifications");
}

- (void)testQuestionListCausesTableReloadOnAvatarNotification {
    ReloadDataWatcher *fakeTableView = [[ReloadDataWatcher alloc] init];
    dataSource.tableView = (UITableView *)fakeTableView;
    [dataSource avatarStoreDidUpdateContent: nil];
    STAssertTrue([fakeTableView didReceiveReloadData], @"Data source should get the table view to reload when new data is available");
}

- (void)testSelectingPlaceholderDoesNotSendSelectionNotification {
    dataSource.notificationCenter = [NSNotificationCenter defaultCenter];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(didReceiveNotification:) name: @"QuestionListDidSelectQuestionNotification" object: nil];
    [dataSource tableView: nil didSelectRowAtIndexPath: firstCell];
    STAssertNil(receivedNotification, @"Shouldn't be notified of selecting the placeholder cell");
}

- (void)testSelectingQuestionSendsSelectionNotification {
    [iPhoneTopic addQuestion: question1];
    dataSource.notificationCenter = [NSNotificationCenter defaultCenter];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(didReceiveNotification:) name: @"QuestionListDidSelectQuestionNotification" object: nil];
    [dataSource tableView: nil didSelectRowAtIndexPath: firstCell];
    STAssertEqualObjects([receivedNotification name], @"QuestionListDidSelectQuestionNotification", @"Question list should notify when a question is selected");
    STAssertEqualObjects([receivedNotification object], question1, @"The selected question should be the object of the notification");
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)testHeightOfAQuestionRowIsAtLeastTheSameAsTheHeightOfTheCell {
    [iPhoneTopic addQuestion: question1];
    UITableViewCell *cell = [dataSource tableView: nil cellForRowAtIndexPath: firstCell];
    CGFloat height = [dataSource tableView: nil heightForRowAtIndexPath: firstCell];
    STAssertTrue(height >= cell.frame.size.height, @"Give the table enough space to draw the view.");
}

@end
