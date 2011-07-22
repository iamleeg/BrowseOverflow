//
//  MockStackOverflowManagerDelegate.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 14/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"
#import "Topic.h"
#import "Question.h"

@implementation MockStackOverflowManagerDelegate

@synthesize fetchError;
@synthesize fetchedQuestions;
@synthesize successQuestion;

- (void)fetchingQuestionsFailedWithError: (NSError *)error {
    self.fetchError = error;
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error {
    self.fetchError = error;
}

- (void)didReceiveQuestions:(NSArray *)questions {
    self.fetchedQuestions = questions;
}

- (void)retrievingAnswersFailedWithError:(NSError *)error {
    self.fetchError = error;
}

- (void)answersReceivedForQuestion:(Question *)question {
    self.successQuestion = question;
}

- (void)receivedQuestionBodyJSON:(NSString *)objectNotation {
    
}

@end
