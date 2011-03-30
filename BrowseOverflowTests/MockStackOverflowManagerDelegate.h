//
//  MockStackOverflowManagerDelegate.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 14/03/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManagerDelegate.h"

@interface MockStackOverflowManagerDelegate : NSObject <StackOverflowManagerDelegate> {
}
@property (retain) NSError *fetchError;
@property (retain) NSArray *fetchedQuestions;

@end
