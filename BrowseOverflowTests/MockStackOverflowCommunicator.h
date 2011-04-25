//
//  MockStackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 17/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicator.h"

@interface MockStackOverflowCommunicator : StackOverflowCommunicator {
    BOOL wasAskedToFetchQuestions;
    BOOL wasAskedToFetchBody;
    NSInteger questionID;
}

- (BOOL)wasAskedToFetchQuestions;
- (BOOL)wasAskedToFetchBody;
- (NSInteger)askedForAnswersToQuestionID;

@end
