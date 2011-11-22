//
//  BrowseOverflowViewControllerTests.m
//  BrowseOverflow
//
//  Created by Graham Lee on 26/07/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "BrowseOverflowViewControllerTests.h"
#import "BrowseOverflowViewController.h"
#import "BrowseOverflowObjectConfiguration.h"
#import "TestObjectConfiguration.h"
#import "TopicTableDataSource.h"
#import "Topic.h"
#import "QuestionListTableDataSource.h"
#import "QuestionDetailDataSource.h"
#import "Question.h"
#import "MockStackOverflowManager.h"
#import "StackOverflowManager.h"
#import "StackOverflowManagerDelegate.h"
#import "ReloadDataWatcher.h"
#import <objc/runtime.h>

static const char *notificationKey = "BrowseOverflowViewControllerTestsAssociatedNotificationKey";
@implementation BrowseOverflowViewController (TestNotificationDelivery)

- (void)browseOverflowControllerTests_userDidSelectTopicNotification: (NSNotification *)note {
    objc_setAssociatedObject(self, notificationKey, note, OBJC_ASSOCIATION_RETAIN);
}

- (void)browseOverflowControllerTests_userDidSelectQuestionNotification: (NSNotification *)note {
    objc_setAssociatedObject(self, notificationKey, note, OBJC_ASSOCIATION_RETAIN);
}
@end

static const char *viewDidAppearKey = "BrowseOverflowViewControllerTestsViewDidAppearKey";
static const char *viewWillDisappearKey = "BrowseOverflowViewControllerTestsViewWillDisappearKey";
static const char *viewWillAppearKey = "BrowseOverflowViewControllerTestsViewWillAppearKey";

@implementation UIViewController (TestSuperclassCalled)

- (void)browseOverflowViewControllerTests_viewDidAppear: (BOOL)animated {
    NSNumber *parameter = [NSNumber numberWithBool: animated];
    objc_setAssociatedObject(self, viewDidAppearKey, parameter, OBJC_ASSOCIATION_RETAIN);
}

- (void)browseOverflowViewControllerTests_viewWillDisappear: (BOOL)animated {
    NSNumber *parameter = [NSNumber numberWithBool: animated];
    objc_setAssociatedObject(self, viewWillDisappearKey, parameter, OBJC_ASSOCIATION_RETAIN);
}

- (void)browseOverflowViewControllerTests_viewWillAppear: (BOOL)animated {
    NSNumber *parameter = [NSNumber numberWithBool: animated];
    objc_setAssociatedObject(self, viewWillAppearKey, parameter, OBJC_ASSOCIATION_RETAIN);
}
@end

@implementation BrowseOverflowViewControllerTests
{
    BrowseOverflowViewController *viewController;
    UITableView *tableView;
    id <UITableViewDataSource, UITableViewDelegate> dataSource;
    SEL realViewDidAppear, testViewDidAppear;
    SEL realViewWillDisappear, testViewWillDisappear;
    SEL realViewWillAppear, testViewWillAppear;
    SEL realUserDidSelectTopic, testUserDidSelectTopic;
    SEL realUserDidSelectQuestion, testUserDidSelectQuestion;
    UINavigationController *navController;
    BrowseOverflowObjectConfiguration *objectConfiguration;
    TestObjectConfiguration *testConfiguration;
    MockStackOverflowManager *manager;
    Question *question;
}

+ (void)swapInstanceMethodsForClass: (Class) cls selector: (SEL)sel1 andSelector: (SEL)sel2 {
    Method method1 = class_getInstanceMethod(cls, sel1);
    Method method2 = class_getInstanceMethod(cls, sel2);
    method_exchangeImplementations(method1, method2);
}

- (void)setUp {
    viewController = [[BrowseOverflowViewController alloc] init];
    tableView = [[UITableView alloc] init];
    viewController.tableView = tableView;
    dataSource = [[TopicTableDataSource alloc] init];
    viewController.dataSource = dataSource;    
    objc_removeAssociatedObjects(viewController);

    realViewDidAppear = @selector(viewDidAppear:);
    testViewDidAppear = @selector(browseOverflowViewControllerTests_viewDidAppear:);
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [UIViewController class] selector: realViewDidAppear andSelector: testViewDidAppear];
    
    realViewWillDisappear = @selector(viewWillDisappear:);
    testViewWillDisappear = @selector(browseOverflowViewControllerTests_viewWillDisappear:);
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [UIViewController class] selector: realViewWillDisappear andSelector: testViewWillDisappear];
    
    realViewWillAppear = @selector(viewWillAppear:);
    testViewWillAppear = @selector(browseOverflowViewControllerTests_viewWillAppear:);
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [UIViewController class] selector: realViewWillAppear andSelector: testViewWillAppear];
    
    realUserDidSelectTopic = @selector(userDidSelectTopicNotification:);
    testUserDidSelectTopic = @selector(browseOverflowControllerTests_userDidSelectTopicNotification:);
    
    realUserDidSelectQuestion = @selector(userDidSelectQuestionNotification:);
    testUserDidSelectQuestion = @selector(browseOverflowControllerTests_userDidSelectQuestionNotification:);
    
    navController = [[UINavigationController alloc] initWithRootViewController: viewController];
    objectConfiguration = [[BrowseOverflowObjectConfiguration alloc] init];
    viewController.objectConfiguration = objectConfiguration;
    testConfiguration = [[TestObjectConfiguration alloc] init];
    manager = [[MockStackOverflowManager alloc] init];
    testConfiguration.objectToReturn = manager;
    
    question = [[Question alloc] init];
}

- (void)tearDown {
    objc_removeAssociatedObjects(viewController);
    question = nil;
    viewController = nil;
    tableView = nil;
    navController = nil;
    objectConfiguration = nil;
    testConfiguration = nil;
    manager = nil;
    
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [UIViewController class] selector: realViewDidAppear andSelector: testViewDidAppear];
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [UIViewController class] selector: realViewWillDisappear andSelector: testViewWillDisappear];
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [UIViewController class] selector: realViewWillAppear andSelector: testViewWillAppear];
}

- (void)testViewControllerHasATableViewProperty {
    objc_property_t tableViewProperty = class_getProperty([viewController class], "tableView");
    STAssertTrue(tableViewProperty != NULL, @"BrowseOverflowViewController needs a table view");
}

- (void)testViewControllerHasADataSourceProperty {
    objc_property_t dataSourceProperty = class_getProperty([viewController class], "dataSource");
    STAssertTrue(dataSourceProperty != NULL, @"View Controller needs a data source");
}

- (void)testViewControllerConnectsDataSourceInViewDidLoad {
    [viewController viewDidLoad];
    STAssertEqualObjects([tableView dataSource], dataSource, @"View controller should have set the table view's data source");
}

- (void)testViewControllerConnectsDelegateInViewDidLoad {
    [viewController viewDidLoad];
    STAssertEqualObjects([tableView delegate], dataSource, @"View controller should have set the table view's delegate");
}

- (void)testViewControllerConnectsTableViewBacklinkInViewDidLoad {
    QuestionListTableDataSource *questionDataSource = [[QuestionListTableDataSource alloc] init];
    viewController.dataSource = questionDataSource;
    [viewController viewDidLoad];
    STAssertEqualObjects(questionDataSource.tableView, tableView, @"Back-link to table view should be set in data source");
}

- (void)testViewControllerHooksUpQuestionListNotificationCenterInViewDidAppear {
    QuestionListTableDataSource *questionDataSource = [[QuestionListTableDataSource alloc] init];
    viewController.dataSource = questionDataSource;
    [viewController viewDidAppear: YES];
    STAssertEqualObjects(questionDataSource.notificationCenter, [NSNotificationCenter defaultCenter], @"");
}

- (void)testDefaultStateOfViewControllerDoesNotReceiveTopicSelectionNotifications {
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [BrowseOverflowViewController class] selector: realUserDidSelectTopic andSelector: testUserDidSelectTopic];
    [[NSNotificationCenter defaultCenter] 
     postNotificationName: TopicTableDidSelectTopicNotification
     object: nil 
     userInfo: nil];
    STAssertNil(objc_getAssociatedObject(viewController, notificationKey), @"Notification should not be received before -viewDidAppear:");
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [BrowseOverflowViewController class] selector: realUserDidSelectTopic andSelector: testUserDidSelectTopic];
}

- (void)testViewControllerReceivesTopicSelectionNotificationAfterViewDidAppear {
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [BrowseOverflowViewController class] selector: realUserDidSelectTopic andSelector: testUserDidSelectTopic];
    [viewController viewDidAppear: NO];
    [[NSNotificationCenter defaultCenter] 
     postNotificationName: TopicTableDidSelectTopicNotification
     object: nil
     userInfo: nil];
    STAssertNotNil(objc_getAssociatedObject(viewController, notificationKey), @"After -viewDidAppear: the view controller should handle selection notifications");
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [BrowseOverflowViewController class] selector: realUserDidSelectTopic andSelector: testUserDidSelectTopic];
}

- (void)testViewControllerDoesNotReceiveTopicSelectNotificationAfterViewWillDisappear {
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [BrowseOverflowViewController class] selector: realUserDidSelectTopic andSelector: testUserDidSelectTopic];
    [viewController viewDidAppear: NO];
    [viewController viewWillDisappear: NO];
    [[NSNotificationCenter defaultCenter]
     postNotificationName: TopicTableDidSelectTopicNotification
     object: nil
     userInfo: nil];
    STAssertNil(objc_getAssociatedObject(viewController, notificationKey), @"After -viewWillDisappear: is called, the view controller should no longer respond to topic selection notifications");
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [BrowseOverflowViewController class] selector: realUserDidSelectTopic andSelector: testUserDidSelectTopic];
}

- (void)testViewControllerCallsSuperViewDidAppear {
    [viewController viewDidAppear: NO];
    STAssertNotNil(objc_getAssociatedObject(viewController, viewDidAppearKey), @"-viewDidAppear: should call through to superclass implementation");
}

- (void)testViewControllerCallsSuperViewWillDisappear {
    [viewController viewWillDisappear: NO];
    STAssertNotNil(objc_getAssociatedObject(viewController, viewWillDisappearKey), @"-viewWillDisappear: should call through to superclass implementation");
}

- (void)testSelectingTopicPushesNewViewController {
    [viewController userDidSelectTopicNotification: nil];
    UIViewController *currentTopVC = navController.topViewController;
    STAssertFalse([currentTopVC isEqual: viewController], @"New view controller should be pushed onto the stack");
    STAssertTrue([currentTopVC isKindOfClass: [BrowseOverflowViewController class]], @"New view controller should be a BrowseOverflowViewController");
}

- (void)testNewViewControllerHasAQuestionListDataSourceForTheSelectedTopic {
    Topic *iPhoneTopic = [[Topic alloc] initWithName: @"iPhone" tag: @"iphone"];
    NSNotification *iPhoneTopicSelectedNotification = [NSNotification notificationWithName: TopicTableDidSelectTopicNotification object: iPhoneTopic];
    [viewController userDidSelectTopicNotification: iPhoneTopicSelectedNotification];
    BrowseOverflowViewController *nextViewController = (BrowseOverflowViewController *)navController.topViewController;
    STAssertTrue([nextViewController.dataSource isKindOfClass: [QuestionListTableDataSource class]], @"Selecting a topic should push a list of questions");
    STAssertEqualObjects([(QuestionListTableDataSource *)[nextViewController dataSource] topic], iPhoneTopic, @"The questions to display should come from the selected topic");
}

- (void)testDefaultStateOfViewControllerDoesNotReceiveQuestionSelectionNotification {
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [BrowseOverflowViewController class] selector: realUserDidSelectQuestion andSelector: testUserDidSelectQuestion];
    [[NSNotificationCenter defaultCenter] postNotificationName: QuestionListDidSelectQuestionNotification object: question userInfo: nil];
    STAssertNil(objc_getAssociatedObject(viewController, notificationKey), @"View controller shouldn't receive question selection notifications by default");
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [BrowseOverflowViewController class] selector: realUserDidSelectQuestion andSelector: testUserDidSelectQuestion];
}

- (void)testViewControllerReceivesQuestionSelectionNotificationAfterViewDidAppear {
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [BrowseOverflowViewController class] selector: realUserDidSelectQuestion andSelector: testUserDidSelectQuestion];
    [viewController viewDidAppear: NO];
    [[NSNotificationCenter defaultCenter] 
     postNotificationName: QuestionListDidSelectQuestionNotification
     object: nil
     userInfo: nil];
    STAssertNotNil(objc_getAssociatedObject(viewController, notificationKey), @"After -viewDidAppear: the view controller should handle question selection notifications");
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [BrowseOverflowViewController class] selector: realUserDidSelectQuestion andSelector: testUserDidSelectQuestion];
}

- (void)testViewControllerDoesNotReceiveQuestionSelectNotificationAfterViewWillDisappear {
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [BrowseOverflowViewController class] selector: realUserDidSelectQuestion andSelector: testUserDidSelectQuestion];
    [viewController viewDidAppear: NO];
    [viewController viewWillDisappear: NO];
    [[NSNotificationCenter defaultCenter]
     postNotificationName: QuestionListDidSelectQuestionNotification
     object: nil
     userInfo: nil];
    STAssertNil(objc_getAssociatedObject(viewController, notificationKey), @"After -viewWillDisappear: is called, the view controller should no longer respond to question selection notifications");
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [BrowseOverflowViewController class] selector: realUserDidSelectQuestion andSelector: testUserDidSelectQuestion];
}

- (void)testSelectingQuestionPushesNewViewController {
    [viewController userDidSelectQuestionNotification: nil];
    UIViewController *currentTopVC = navController.topViewController;
    STAssertFalse([currentTopVC isEqual: viewController], @"New view controller should be pushed onto the stack");
    STAssertTrue([currentTopVC isKindOfClass: [BrowseOverflowViewController class]], @"New view controller should be a BrowseOverflowViewController");
}

- (void)testViewControllerPushedOnQuestionSelectionHasQuestionDetailDataSourceForSelectedQuestion {
    Question *sampleQuestion = [[Question alloc] init];
    NSNotification *note = [NSNotification notificationWithName: QuestionListDidSelectQuestionNotification object: sampleQuestion];
    [viewController userDidSelectQuestionNotification: note];
    BrowseOverflowViewController *nextVC = (BrowseOverflowViewController *)navController.topViewController;
    STAssertTrue([nextVC.dataSource isKindOfClass: [QuestionDetailDataSource class]], @"Selecting a question should show details of that question");
    STAssertEqualObjects([(QuestionDetailDataSource *)nextVC.dataSource question], sampleQuestion, @"Details should be shown for the selected question");
}

- (void)testSelectingTopicNotificationPassesObjectConfigurationToNewViewController {
    [viewController userDidSelectTopicNotification: nil];
    BrowseOverflowViewController *newTopVC = (BrowseOverflowViewController *)navController.topViewController;
    STAssertEqualObjects(newTopVC.objectConfiguration, objectConfiguration, @"The object configuration should be passed through to the new view controller");
}

- (void)testSelectingQuestionNotificationPassesObjectConfigurationToNewViewController {
    [viewController userDidSelectQuestionNotification: nil];
    BrowseOverflowViewController *newTopVC = (BrowseOverflowViewController *)navController.topViewController;
    STAssertEqualObjects(newTopVC.objectConfiguration, objectConfiguration, @"The object configuration should be passed through to the new view controller");
}

- (void)testViewWillAppearCreatesAStackOverflowManager {
    [viewController viewWillAppear: YES];
    STAssertNotNil(viewController.manager, @"Set up a stack overflow manager before the view appears");
}

- (void)testViewWillAppearCallsSuper {
    [viewController viewWillAppear: YES];
    STAssertNotNil(objc_getAssociatedObject(viewController, viewWillAppearKey), @"-viewWillAppear: is documented to require a call to super");
}

- (void)testViewWillAppearOnQuestionListInitiatesLoadingOfQuestions {
    viewController.objectConfiguration = testConfiguration;
    viewController.dataSource = [[QuestionListTableDataSource alloc] init];
    [viewController viewWillAppear: YES];
    STAssertTrue([manager didFetchQuestions], @"View controller should have arranged for question content to be downloaded");
}

- (void)testViewWillAppearOnQuestionDetailInitiatesLoadingOfAnswersAndBody {
    viewController.objectConfiguration = testConfiguration;
    viewController.dataSource = [[QuestionDetailDataSource alloc] init];
    [viewController viewWillAppear: YES];
    STAssertTrue([manager didFetchQuestionBody], @"View controller should arrange for question detail to be loaded");
    STAssertTrue([manager didFetchAnswers], @"View controller should arrange for answers to be loaded");
}

- (void)testQuestionsNotLoadedForDetailView {
    viewController.objectConfiguration = testConfiguration;
    viewController.dataSource = [[QuestionDetailDataSource alloc] init];
    [viewController viewWillAppear: YES];
    STAssertFalse([manager didFetchQuestions], @"Don't load question when displaying answers");
}

- (void)testDetailsNotLoadedForQuestionListView {
    viewController.objectConfiguration = testConfiguration;
    viewController.dataSource = [[QuestionListTableDataSource alloc] init];
    [viewController viewWillAppear: YES];
    STAssertFalse([manager didFetchQuestionBody], @"View controller should not arrange for question detail to be loaded");
    STAssertFalse([manager didFetchAnswers], @"View controller should not arrange for answers to be loaded");
}

- (void)testNoDataLoadedForTopicListView {
    viewController.objectConfiguration = testConfiguration;
    STAssertFalse([manager didFetchQuestions], @"Don't load question when displaying topics");
    STAssertFalse([manager didFetchQuestionBody], @"View controller should not arrange for question detail to be loaded");
    STAssertFalse([manager didFetchAnswers], @"View controller should not arrange for answers to be loaded");
}

- (void)testViewControllerConformsToStackOverflowManagerDelegateProtocol {
    STAssertTrue([viewController conformsToProtocol: @protocol(StackOverflowManagerDelegate)], @"View controllers need to be StackOverflowManagerDelegates");
}

- (void)testViewControllerConfiguredAsStackOverflowManagerDelegateOnManagerCreation {
    [viewController viewWillAppear: YES];
    STAssertEqualObjects(viewController.manager.delegate, viewController, @"View controller sets itself as the manager's delegate");
}

- (void)testDownloadedQuestionsAreAddedToTopic {
    QuestionListTableDataSource *topicDataSource = [[QuestionListTableDataSource alloc] init];
    viewController.dataSource = topicDataSource;
    Topic *topic = [[Topic alloc] initWithName: @"iPhone" tag: @"iphone"];
    topicDataSource.topic = topic;
    Question *question1 = [[Question alloc] init];
    [viewController didReceiveQuestions: [NSArray arrayWithObject: question1]];
    STAssertEqualObjects([topic.recentQuestions lastObject], question1, @"Question was added to the topic");
}

- (void)testTableViewReloadedWhenQuestionsReceived {
    QuestionListTableDataSource *topicDataSource = [[QuestionListTableDataSource alloc] init];
    viewController.dataSource = topicDataSource;
    ReloadDataWatcher *watcher = [[ReloadDataWatcher alloc] init];
    viewController.tableView = (UITableView *)watcher;
    [viewController didReceiveQuestions: [NSArray array]];
    STAssertTrue([watcher didReceiveReloadData], @"Table view was reloaded after fetching new data");
}

- (void)testTableViewReloadedWhenAnswersReceived {
    QuestionDetailDataSource *detailDataSource = [[QuestionDetailDataSource alloc] init];
    viewController.dataSource = detailDataSource;
    ReloadDataWatcher *watcher = [[ReloadDataWatcher alloc] init];
    viewController.tableView = (UITableView *)watcher;
    [viewController answersReceivedForQuestion: nil];
    STAssertTrue([watcher didReceiveReloadData], @"Table view data was reloaded after fetching new answers");
}

- (void)testQuestionListViewIsGivenAnAvatarStore {
    QuestionListTableDataSource *listDataSource = [[QuestionListTableDataSource alloc] init];
    viewController.dataSource = listDataSource;
    [viewController viewWillAppear: YES];
    STAssertNotNil(listDataSource.avatarStore, @"The avatarStore property should be configured in -viewWillAppear:");
}

- (void)testQuestionDetailViewIsGivenAnAvatarStore {
    QuestionDetailDataSource *detailDataSource = [[QuestionDetailDataSource alloc] init];
    viewController.dataSource = detailDataSource;
    [viewController viewWillAppear: YES];
    STAssertNotNil(detailDataSource.avatarStore, @"The avatarStore property should be configured in -viewWillAppear:");
}

- (void)testTableReloadedWhenQuestionBodyReceived {
    QuestionDetailDataSource *detailDataSource = [[QuestionDetailDataSource alloc] init];
    viewController.dataSource = detailDataSource;
    ReloadDataWatcher *watcher = [[ReloadDataWatcher alloc] init];
    viewController.tableView = (UITableView *)watcher;
    [viewController bodyReceivedForQuestion: nil];
    STAssertTrue([watcher didReceiveReloadData], @"Table reloaded when question body received");
}

@end
