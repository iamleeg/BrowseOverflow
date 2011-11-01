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
#import "TopicTableDataSource.h"
#import "Topic.h"
#import "QuestionListTableDataSource.h"
#import "QuestionDetailDataSource.h"
#import "Question.h"
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
@implementation UIViewController (TestSuperclassCalled)

- (void)browseOverflowViewControllerTests_viewDidAppear: (BOOL)animated {
    NSNumber *parameter = [NSNumber numberWithBool: animated];
    objc_setAssociatedObject(self, viewDidAppearKey, parameter, OBJC_ASSOCIATION_RETAIN);
}

- (void)browseOverflowViewControllerTests_viewWillDisappear: (BOOL)animated {
    NSNumber *parameter = [NSNumber numberWithBool: animated];
    objc_setAssociatedObject(self, viewWillDisappearKey, parameter, OBJC_ASSOCIATION_RETAIN);
}

@end

@implementation BrowseOverflowViewControllerTests
{
    BrowseOverflowViewController *viewController;
    UITableView *tableView;
    id <UITableViewDataSource, UITableViewDelegate> dataSource;
    SEL realViewDidAppear, testViewDidAppear;
    SEL realViewWillDisappear, testViewWillDisappear;
    SEL realUserDidSelectTopic, testUserDidSelectTopic;
    SEL realUserDidSelectQuestion, testUserDidSelectQuestion;
    UINavigationController *navController;
    BrowseOverflowObjectConfiguration *objectConfiguration;
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
    
    realUserDidSelectTopic = @selector(userDidSelectTopicNotification:);
    testUserDidSelectTopic = @selector(browseOverflowControllerTests_userDidSelectTopicNotification:);
    
    realUserDidSelectQuestion = @selector(userDidSelectQuestionNotification:);
    testUserDidSelectQuestion = @selector(browseOverflowControllerTests_userDidSelectQuestionNotification:);
    
    navController = [[UINavigationController alloc] initWithRootViewController: viewController];
    objectConfiguration = [[BrowseOverflowObjectConfiguration alloc] init];
    viewController.objectConfiguration = objectConfiguration;
}

- (void)tearDown {
    objc_removeAssociatedObjects(viewController);
    viewController = nil;
    tableView = nil;
    navController = nil;
    objectConfiguration = nil;
    
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [UIViewController class] selector: realViewDidAppear andSelector: testViewDidAppear];
    [BrowseOverflowViewControllerTests swapInstanceMethodsForClass: [UIViewController class] selector: realViewWillDisappear andSelector: testViewWillDisappear];
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
    [[NSNotificationCenter defaultCenter] postNotificationName: QuestionListDidSelectQuestionNotification object: nil userInfo: nil];
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
@end
