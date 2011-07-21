//
//  MockStackOverflowManager.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 13/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "MockStackOverflowManager.h"


@implementation MockStackOverflowManager

- (NSInteger)topicFailureErrorCode {
    return topicFailureErrorCode;
}

- (NSInteger)bodyFailureErrorCode {
    return bodyFailureErrorCode;
}

- (NSInteger)answerFailureErrorCode {
    return answerFailureErrorCode;
}

- (void)searchingForQuestionsFailedWithError: (NSError *)error {
    topicFailureErrorCode = [error code];
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error {
    bodyFailureErrorCode = [error code];
}

- (void)fetchingAnswersFailedWithError:(NSError *)error {
    answerFailureErrorCode = [error code];
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation {
    topicSearchString = objectNotation;
}

- (void)receivedQuestionBodyJSON:(NSString *)objectNotation {
    questionBodyString = objectNotation;
}

- (void)receivedAnswerListJSON:(NSString *)objectNotation {
    answerListString = objectNotation;
}

- (NSString *)topicSearchString {
    return topicSearchString;
}

- (NSString *)questionBodyString {
    return questionBodyString;
}

- (NSString *)answerListString {
    return answerListString;
}

@end
