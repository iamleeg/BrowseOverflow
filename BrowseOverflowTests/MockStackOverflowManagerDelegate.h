//
//  MockStackOverflowManagerDelegate.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 14/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManagerDelegate.h"

@class Question;

@interface MockStackOverflowManagerDelegate : NSObject <StackOverflowManagerDelegate>
@property (strong) NSError *fetchError;
@property (strong) NSArray *fetchedQuestions;
@property (strong) Question *successQuestion;
@property (strong) Question *bodyQuestion;

@end
