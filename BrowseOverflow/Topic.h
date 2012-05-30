//
//  Topic.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 17/02/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Question;

/**
 * A class representing a particular subject on Stack Overflow.
 */
@interface Topic : NSObject
/**
 * A name for this topic, suitable for displaying in the UI.
 */
@property (readonly, strong) NSString *name;
/**
 * The text with which questions on this topic get tagged on the website.
 */
@property (readonly, strong) NSString *tag;

/**
 * Initialise a new instance of this class with a particular name and tag.
 */
- (id)initWithName:(NSString *)newName tag: (NSString *)tag;
/**
 * A list of questions recently asked on this topic.
 */
- (NSArray *)recentQuestions;
/**
 * Add a new question to this topic.
 */
- (void)addQuestion: (Question *)question;

@end
