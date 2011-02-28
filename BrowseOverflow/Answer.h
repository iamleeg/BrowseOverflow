//
//  Answer.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 25/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;

@interface Answer : NSObject {
    
}

@property (copy) NSString *text;
@property (retain) Person *person;
@property BOOL accepted;
@property NSInteger score;

- (NSComparisonResult)compare: (Answer *)otherAnswer;

@end
