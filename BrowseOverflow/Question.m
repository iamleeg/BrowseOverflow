//
//  Question.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 21/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "Question.h"


@implementation Question

@synthesize date;
@synthesize title;
@synthesize score;

- (void)dealloc {
    [date release];
    [title release];
    [super dealloc];
}

@end
