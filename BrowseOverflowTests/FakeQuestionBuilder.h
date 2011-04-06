//
//  FakeQuestionBuilder.h
//  BrowseOverflow
//
//  Created by Graham Lee on 30/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionBuilder.h"

@class Question;

@interface FakeQuestionBuilder : QuestionBuilder {
}
@property (copy) NSString *JSON;
@property (copy) NSArray *arrayToReturn;
@property (copy) NSError *errorToSet;
@property (retain) Question *questionToFill;
@end
