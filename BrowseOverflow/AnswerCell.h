//
//  AnswerCell.h
//  BrowseOverflow
//
//  Created by Graham Lee on 26/09/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UILabel *acceptedIndicator;
@property (nonatomic, weak) IBOutlet UILabel *personName;
@property (nonatomic, weak) IBOutlet UIImageView *personAvatar;
@property (nonatomic, weak) IBOutlet UIWebView *bodyWebView;

@end
