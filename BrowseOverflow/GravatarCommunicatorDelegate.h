//
//  GravatarCommunicatorDelegate.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 26/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol GravatarCommunicatorDelegate <NSObject>

- (void)communicatorReceivedData: (NSData *)data forURL: (NSURL *)url;

- (void)communicatorGotErrorForURL: (NSURL *)url;

@end
