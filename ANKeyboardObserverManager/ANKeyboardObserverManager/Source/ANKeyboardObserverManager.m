//
//  ANKeyboardObserverManager.m
//  ANKeyboardObserverManager
//
//  Created by liuyan on 7/22/15.
//  Copyright (c) 2015 Candyan. All rights reserved.
//

#import "ANKeyboardObserverManager.h"

@implementation ANKeyboardObserverManager

#pragma mark - singlton

+ (ANKeyboardObserverManager *)sharedManager
{
    static ANKeyboardObserverManager *instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      instance = [[ANKeyboardObserverManager alloc] init];
    });

    return instance;
}

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    if (self) {
        _keyboardWillShowBlocks = [NSMapTable weakToStrongObjectsMapTable];
        _keyboardWillHideBlocks = [NSMapTable weakToStrongObjectsMapTable];

        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(an_keyboardWillShowNotification:)
                       name:UIKeyboardWillShowNotification
                     object:nil];
        [center addObserver:self
                   selector:@selector(an_keyboardWillHiddenNotification:)
                       name:UIKeyboardWillHideNotification
                     object:nil];
    }
    return self;
}

#pragma mark - dealloc

- (void)dealloc
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [center removeObserver:self name:UIKeyboardWillShowNotification object:nil];

    [_keyboardWillHideBlocks removeAllObjects];
    [_keyboardWillShowBlocks removeAllObjects];
}

#pragma mark - add & remove

- (void)addKeyboardObserver:(NSObject *)observer
  withkeyboardWillShowBlock:(ANKeyboardObserveBlock)willShowBlock
      keyboardWillHideBlock:(ANKeyboardObserveBlock)willHideBlock
{
    if (observer == nil) {
        return;
    }

    if (willHideBlock != nil) {
        [_keyboardWillHideBlocks setObject:[willHideBlock copy] forKey:observer];
    }

    if (willShowBlock) {
        [_keyboardWillShowBlocks setObject:[willShowBlock copy] forKey:observer];
    }
}

- (void)removeKeyboardObserver:(NSObject *)observer
{
    if (observer == nil) {
        return;
    }

    [_keyboardWillShowBlocks removeObjectForKey:observer];
    [_keyboardWillHideBlocks removeObjectForKey:observer];
}

#pragma mark - Keyboard Notification

- (void)an_keyboardWillShowNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval keyboardAnimationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    NSEnumerator *keyEnumerator = _keyboardWillShowBlocks.keyEnumerator;

    NSObject *key;
    while (key = [keyEnumerator nextObject]) {
        ANKeyboardObserveBlock block = [_keyboardWillShowBlocks objectForKey:key];
        block(keyboardEndFrame, keyboardAnimationDuration, userInfo);
    }
}

- (void)an_keyboardWillHiddenNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval keyboardAnimationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    NSEnumerator *keyEnumerator = _keyboardWillHideBlocks.keyEnumerator;

    NSObject *key;
    while (key = [keyEnumerator nextObject]) {
        ANKeyboardObserveBlock block = [_keyboardWillHideBlocks objectForKey:key];
        block(keyboardEndFrame, keyboardAnimationDuration, userInfo);
    }
}

@end
