//
//  QuestionBuilderTests.h
//  BrowseOverflow
//
//  Created by Graham Lee on 01/04/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>

@class QuestionBuilder;
@class Question;

@interface QuestionBuilderTests : XCTestCase {
    QuestionBuilder *questionBuilder;
    Question *question;
}

@end
