//
//  AvatarStore.h
//  BrowseOverflow
//
//  Created by Graham J Lee on 26/05/2011.
//  Copyright 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AvatarStore : NSObject {
    NSMutableDictionary *dataCache;
}

- (NSData *)dataForURL: (NSURL *)url;
- (void)didReceiveMemoryWarning;

@end
