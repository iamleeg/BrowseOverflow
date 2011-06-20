//
//  FakeGravatarDelegate.m
//  BrowseOverflow
//
//  Created by Graham J Lee on 26/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "FakeGravatarDelegate.h"


@implementation FakeGravatarDelegate

@synthesize reportedURL;
@synthesize reportedData;

- (void)communicatorReceivedData:(NSData *)data forURL:(NSURL *)url {
    self.reportedURL = url;
    self.reportedData = data;
}

- (void)communicatorGotErrorForURL:(NSURL *)url {
    self.reportedURL = url;
}
@end
