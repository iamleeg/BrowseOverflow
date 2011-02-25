//
//  Answer.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 25/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "Answer.h"


@implementation Answer

@synthesize text;

- (void)dealloc {
    [text release];
    [super dealloc];
}

@end
