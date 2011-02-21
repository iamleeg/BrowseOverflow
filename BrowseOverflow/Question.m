//
//  Question.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 21/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "Question.h"


@implementation Question

@synthesize askedDate;

- (void)dealloc {
    [askedDate release];
    [super dealloc];
}

@end
