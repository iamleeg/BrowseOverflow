//
//  BrowseOverflowObjectConfiguration.m
//  BrowseOverflow
//
//  Created by Graham Lee on 01/11/2011.
//  Copyright (c) 2011 Fuzzy Aliens Ltd. All rights reserved.
//

#import "BrowseOverflowObjectConfiguration.h"
#import "StackOverflowManager.h"
#import "StackOverflowCommunicator.h"
#import "QuestionBuilder.h"
#import "AnswerBuilder.h"
#import "AvatarStore.h"

@implementation BrowseOverflowObjectConfiguration

- (StackOverflowManager *)stackOverflowManager {
    StackOverflowManager *manager = [[StackOverflowManager alloc] init];
    manager.communicator = [[StackOverflowCommunicator alloc] init];
    manager.communicator.delegate = manager;
    manager.bodyCommunicator = [[StackOverflowCommunicator alloc] init];
    manager.bodyCommunicator.delegate = manager;
    manager.questionBuilder = [[QuestionBuilder alloc] init];
    manager.answerBuilder = [[AnswerBuilder alloc] init];
    return manager;
}

- (AvatarStore *)avatarStore {
    static AvatarStore *avatarStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        avatarStore = [[AvatarStore alloc] init];
        [avatarStore useNotificationCenter: [NSNotificationCenter defaultCenter]];
    });
    return avatarStore;
}

@end
