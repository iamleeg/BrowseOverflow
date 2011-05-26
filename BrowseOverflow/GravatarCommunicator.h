//
//  GravatarCommunicator.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 26/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GravatarCommunicatorDelegate.h"

@interface GravatarCommunicator : NSObject {
    
}
@property (retain) NSURL *url;
@property (retain) NSMutableData *receivedData;
@property (assign) id <GravatarCommunicatorDelegate> delegate;

@end
