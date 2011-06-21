//
//  Person.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 24/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject {
    
}

@property (readonly, strong) NSString *name;
@property (readonly, strong) NSURL *avatarURL;

- (id)initWithName: (NSString *)aName avatarLocation: (NSString *)location;

@end
