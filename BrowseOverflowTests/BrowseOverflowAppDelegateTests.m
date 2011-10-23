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
}

- (void)setUp {
    window = [[UIWindow alloc] init];
    navigationController = [[UINavigationController alloc] init];
    appDelegate = [[BrowseOverflowAppDelegate alloc] init];
    appDelegate.window = window;
    appDelegate.navigationController = navigationController;
}

- (void)tearDown {
    window = nil;
    navigationController = nil;
    appDelegate = nil;
}

- (void)testWindowIsKeyAfterApplicationLaunch {
    [appDelegate application: nil didFinishLaunchingWithOptions: nil];
    STAssertTrue(window.keyWindow, @"App delegate's window should be key");
}

- (void)testWindowHasRootNavigationControllerAfterApplicationLaunch {
    [appDelegate application: nil didFinishLaunchingWithOptions: nil];
    STAssertEqualObjects(window.rootViewController, navigationController, @"App delegate's navigation controller should be the root VC");
}

- (void)testAppDidFinishLaunchingReturnsYES {
    STAssertTrue([appDelegate application: nil didFinishLaunchingWithOptions: nil], @"Method should return YES");
}

- (void)testNavigationControllerShowsABrowseOverflowViewController {
    [appDelegate application: nil didFinishLaunchingWithOptions: nil];
    id visibleViewController = appDelegate.navigationController.topViewController;
    STAssertTrue([visibleViewController isKindOfClass: [BrowseOverflowViewController class]], @"Views in this app are supplied by BrowseOverflowViewControllers");
}

- (void)testFirstViewControllerHasATopicTableDataSource {
    [appDelegate application: nil didFinishLaunchingWithOptions: nil];
    BrowseOverflowViewController *viewController = (BrowseOverflowViewController *)appDelegate.navigationController.topViewController;
    STAssertTrue([viewController.dataSource isKindOfClass: [TopicTableDataSource class]], @"First view should display a list of topics");
}

@end
