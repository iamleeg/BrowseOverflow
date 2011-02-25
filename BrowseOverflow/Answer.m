//
//  Answer.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 25/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "Answer.h"
#import "Person.h"

@implementation Answer

@synthesize text;
@synthesize person;
@synthesize accepted;
@synthesize score;

- (void)dealloc {
    [text release];
    [person release];
    [super dealloc];
}

@end
