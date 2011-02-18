//
//  Topic.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 17/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Topic : NSObject {
    
}

@property (readonly) NSString *name;
@property (readonly) NSString *tag;

- (id)initWithName: (NSString *)newName;
- (id)initWithName:(NSString *)newName tag: (NSString *)tag;

@end
