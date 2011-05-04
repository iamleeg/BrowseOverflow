//
//  FakeAnswerBuilder.h
//  BrowseOverflow
//
//  Created by Graham Lee on 25/04/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnswerBuilder.h"

@class Question;

@interface FakeAnswerBuilder : AnswerBuilder {
    
}

@property (retain) NSString *receivedJSON;
@property (retain) Question *questionToFill;
@property (retain) NSError *error;
@property BOOL successful;

@end
