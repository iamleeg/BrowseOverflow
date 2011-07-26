//
//  BrowseOverflowViewControllerTests.m
//  BrowseOverflow
//
//  Created by Graham Lee on 26/07/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "BrowseOverflowViewControllerTests.h"
#import "BrowseOverflowViewController.h"

@implementation BrowseOverflowViewControllerTests
{
    BrowseOverflowViewController *viewController;
}

- (void)setUp {
    viewController = [[BrowseOverflowViewController alloc] init];
}

- (void)tearDown {
    viewController = nil;
}

- (void)testViewControllerHasATableViewProperty {
    objc_property_t tableViewProperty = class_getProperty([BrowseOverflowViewController class], "tableView");
    STAssertTrue(tableViewProperty != NULL, @"BrowseOverflowViewController needs a table view");
}

- (void)testDefaultTableViewIsNil {
    STAssertNil(viewController.tableView, @"View Controller's default table view should be nil");
}

@end
