//
//  BrowseOverflowViewController.m
//  BrowseOverflow
//
//  Created by Graham Lee on 25/07/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "BrowseOverflowViewController.h"
#import "BrowseOverflowObjectConfiguration.h"
#import "TopicTableDataSource.h"
#import "QuestionListTableDataSource.h"
#import "QuestionDetailDataSource.h"
#import "StackOverflowManager.h"
#import <objc/runtime.h>

@implementation BrowseOverflowViewController

@synthesize tableView;
@synthesize dataSource;
@synthesize objectConfiguration;
@synthesize manager;

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.manager = [objectConfiguration stackOverflowManager];
    self.manager.delegate = self;
    if ([self.dataSource isKindOfClass: [QuestionListTableDataSource class]]) {
        Topic *selectedTopic = [(QuestionListTableDataSource *)self.dataSource topic];
        [self.manager fetchQuestionsOnTopic: selectedTopic];
    }
    else if ([self.dataSource isKindOfClass: [QuestionDetailDataSource class]]) {
        Question *selectedQuestion = [(QuestionDetailDataSource *)self.dataSource question];
        [self.manager fetchBodyForQuestion: selectedQuestion];
        [self.manager fetchAnswersForQuestion: selectedQuestion];
    }
}

#pragma mark - Notification handling

- (void)userDidSelectTopicNotification: (NSNotification *)note {
    Topic * selectedTopic = (Topic *)[note object];
    BrowseOverflowViewController *nextViewController = [[BrowseOverflowViewController alloc] init];
    QuestionListTableDataSource *questionsDataSource = [[QuestionListTableDataSource alloc] init];
    questionsDataSource.topic = selectedTopic;
    nextViewController.dataSource = questionsDataSource;
    nextViewController.objectConfiguration = self.objectConfiguration;
    [[self navigationController] pushViewController: nextViewController animated: YES];
}

- (void)userDidSelectQuestionNotification: (NSNotification *)note {
    Question *selectedQuestion = (Question *)[note object];
    BrowseOverflowViewController *nextViewController = [[BrowseOverflowViewController alloc] init];
    QuestionDetailDataSource *detailDataSource = [[QuestionDetailDataSource alloc] init];
    detailDataSource.question = selectedQuestion;
    nextViewController.dataSource = detailDataSource;
    nextViewController.objectConfiguration = self.objectConfiguration;
    [[self navigationController] pushViewController: nextViewController animated: YES];
}

#pragma mark - StackOverflowManagerDelegate

- (void)fetchingQuestionsFailedWithError:(NSError *)error {
    
}

- (void)didReceiveQuestions:(NSArray *)questions {
    
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error {
    
}

- (void)retrievingAnswersFailedWithError:(NSError *)error {
    
}

- (void)answersReceivedForQuestion:(Question *)question {
    
}

- (void)receivedQuestionBodyJSON:(NSString *)objectNotation {
    
}

@end
