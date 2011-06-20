//
//  NonNetworkedStackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 12/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicator.h"

@interface NonNetworkedStackOverflowCommunicator : StackOverflowCommunicator {
    
}

@property (copy) NSData *receivedData;

@end
