//
//  FakeURLResponse.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 13/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FakeURLResponse : NSObject {
    NSInteger statusCode;
}

- (id)initWithStatusCode: (NSInteger)code;
- (NSInteger)statusCode;

@end
