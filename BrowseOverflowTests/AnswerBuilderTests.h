//
//  AnswerBuilderTests.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 04/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
//#import "application_headers" as required

@class AnswerBuilder;
@class Question;

@interface AnswerBuilderTests : XCTestCase {
    AnswerBuilder *answerBuilder;
    Question *question;
}

@end
