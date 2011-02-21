//
//  Topic.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 17/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * A class representing a particular subject on Stack Overflow.
 */
@interface Topic : NSObject {
    
}
/**
 * A name for this topic, suitable for displaying in the UI.
 */
@property (readonly) NSString *name;
/**
 * The text with which questions on this topic get tagged on the website.
 */
@property (readonly) NSString *tag;

/**
 * Initialise a new instance of this class with a particular name and tag.
 */
- (id)initWithName:(NSString *)newName tag: (NSString *)tag;
/**
 * A list of questions recently asked on this topic.
 */
- (NSArray *)recentQuestions;

@end
