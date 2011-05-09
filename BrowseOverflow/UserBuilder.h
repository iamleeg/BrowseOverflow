//
//  UserBuilder.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 09/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person;
/**
 * Construct Person instances from dictionaries describing them.
 */
@interface UserBuilder : NSObject {
    
}
/**
 * Given a dictionary that describes a person on Stack Overflow, create
 * a Person object with the supplied properties.
 */
+ (Person *) personFromDictionary: (NSDictionary *) ownerValues;

@end
