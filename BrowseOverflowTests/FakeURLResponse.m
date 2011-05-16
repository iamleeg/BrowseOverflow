//
//  FakeURLResponse.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 13/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "FakeURLResponse.h"


@implementation FakeURLResponse

- (id)initWithStatusCode:(NSInteger)code {
    if ((self = [super init])) {
        statusCode = code;
    }
    return self;
}

- (NSInteger)statusCode {
    return statusCode;
}

@end
