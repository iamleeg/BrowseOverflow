//
//  QuestionDetailCell.h
//  BrowseOverflow
//
//  Created by Graham Lee on 30/08/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionDetailCell : UITableViewCell

@property (weak) IBOutlet UIWebView *bodyWebView;
@property (weak) IBOutlet UILabel *titleLabel;
@property (weak) IBOutlet UILabel *scoreLabel;
@property (weak) IBOutlet UILabel *nameLabel;
@property (weak) IBOutlet UIImageView *avatarView;

@end
