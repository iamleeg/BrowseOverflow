//
//  MockStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 17/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "MockStackOverflowCommunicator.h"


@implementation MockStackOverflowCommunicator

- (void)searchForQuestionsWithTag:(NSString *)tag {
    wasAskedToFetchQuestions = YES;
}

- (BOOL)wasAskedToFetchQuestions {
    return wasAskedToFetchQuestions;
}
@end
