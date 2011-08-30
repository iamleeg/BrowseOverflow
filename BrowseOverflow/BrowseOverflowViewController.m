//
//  BrowseOverflowViewController.m
//  BrowseOverflow
//
//  Created by Graham Lee on 25/07/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "BrowseOverflowViewController.h"
#import "TopicTableDataSource.h"
#import "QuestionListTableDataSource.h"
#import <objc/runtime.h>

@implementation BrowseOverflowViewController

@synthesize tableView;
@synthesize dataSource;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self.dataSource;
    self.tableView.dataSource = self.dataSource;
    objc_property_t tableViewProperty = class_getProperty([dataSource class], "tableView");
    if (tableViewProperty) {
        [dataSource setValue: tableView forKey: @"tableView"];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    [[NSNotificationCenter defaultCenter]
     addObserver: self 
     selector: @selector(userDidSelectTopicNotification:)
     name: TopicTableDidSelectTopicNotification
     object: nil];
    [[NSNotificationCenter defaultCenter]
     addObserver: self 
     selector: @selector(userDidSelectQuestionNotification:)
     name: QuestionListDidSelectQuestionNotification
     object: nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter]
     removeObserver: self];
}

#pragma mark - Notification handling

- (void)userDidSelectTopicNotification: (NSNotification *)note {
    Topic * selectedTopic = (Topic *)[note object];
    BrowseOverflowViewController *nextViewController = [[BrowseOverflowViewController alloc] init];
    QuestionListTableDataSource *questionsDataSource = [[QuestionListTableDataSource alloc] init];
    questionsDataSource.topic = selectedTopic;
    nextViewController.dataSource = questionsDataSource;
    [[self navigationController] pushViewController: nextViewController animated: YES];
}

- (void)userDidSelectQuestionNotification: (NSNotification *)note {
    
}
@end
