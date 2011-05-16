//
//  MockStackOverflowManager.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 13/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicatorDelegate.h"

@interface MockStackOverflowManager : NSObject <StackOverflowCommunicatorDelegate> {
    NSInteger topicFailureErrorCode;
    NSInteger bodyFailureErrorCode;
    NSInteger answerFailureErrorCode;
}

- (NSInteger)topicFailureErrorCode;
- (NSInteger)bodyFailureErrorCode;
- (NSInteger)answerFailureErrorCode;

@end
