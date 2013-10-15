//
//  BrowseOverflowAppDelegateTests.m
//  BrowseOverflow
//
//  Created by Graham Lee on 17/10/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "BrowseOverflowAppDelegateTests.h"

#import <UIKit/UIKit.h>
#import "BrowseOverflowAppDelegate.h"
#import "BrowseOverflowViewController.h"
#import "TopicTableDataSource.h"

@implementation BrowseOverflowAppDelegateTests {
    UIWindow *window;
    UINavigationController *navigationController;
    BrowseOverflowAppDelegate *appDelegate;
    BOOL didFinishLaunchingWithOptionsReturn;
}

- (void)setUp {
    window = [[UIWindow alloc] init];
    navigationController = [[UINavigationController alloc] init];
    appDelegate = [[BrowseOverflowAppDelegate alloc] init];
    appDelegate.window = window;
    appDelegate.navigationController = navigationController;
    didFinishLaunchingWithOptionsReturn = [appDelegate application: nil didFinishLaunchingWithOptions: nil];
}

- (void)tearDown {
    window = nil;
    navigationController = nil;
    appDelegate = nil;
}

- (void)testWindowIsKeyAfterApplicationLaunch {
    XCTAssertTrue(window.keyWindow, @"App delegate's window should be key");
}

- (void)testWindowHasRootNavigationControllerAfterApplicationLaunch {
    XCTAssertEqualObjects(window.rootViewController, navigationController, @"App delegate's navigation controller should be the root VC");
}

- (void)testAppDidFinishLaunchingReturnsYES {
    XCTAssertTrue(didFinishLaunchingWithOptionsReturn, @"Method should return YES");
}

- (void)testNavigationControllerShowsABrowseOverflowViewController {
    id visibleViewController = appDelegate.navigationController.topViewController;
    XCTAssertTrue([visibleViewController isKindOfClass: [BrowseOverflowViewController class]], @"Views in this app are supplied by BrowseOverflowViewControllers");
}

- (void)testFirstViewControllerHasATopicTableDataSource {
    BrowseOverflowViewController *viewController = (BrowseOverflowViewController *)appDelegate.navigationController.topViewController;
    XCTAssertTrue([viewController.dataSource isKindOfClass: [TopicTableDataSource class]], @"First view should display a list of topics");
}

- (void)testTopicListIsNotEmptyOnAppLaunch {
    id <UITableViewDataSource> dataSource = [(BrowseOverflowViewController *)[appDelegate.navigationController topViewController] dataSource];
    XCTAssertFalse([dataSource tableView: nil numberOfRowsInSection: 0] == 0, @"There should be some rows to display");
}

- (void)testFirstViewControllerHasAnObjectConfiguration {
    BrowseOverflowViewController *topicViewController = (BrowseOverflowViewController *)[appDelegate.navigationController topViewController];
    XCTAssertNotNil(topicViewController.objectConfiguration, @"The view controller should have an object configuration instance");
}

@end
