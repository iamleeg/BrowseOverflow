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
@synthesize title;
@synthesize score;

- (void)dealloc {
    [askedDate release];
    [title release];
    [super dealloc];
}

@end
