//
//  ANKeyboardObserverManager.h
//  ANKeyboardObserverManager
//
//  Created by liuyan on 7/22/15.
//  Copyright (c) 2015 Candyan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ANKeyboardObserveBlock)(CGRect keyboardEndFrame, NSTimeInterval animateDuration, NSDictionary *info);

@interface ANKeyboardObserverManager : NSObject {
    NSMapTable *_keyboardWillHideBlocks;
    NSMapTable *_keyboardWillShowBlocks;
}

+ (ANKeyboardObserverManager *)sharedManager;

- (void)addKeyboardObserver:(NSObject *)observer
  withkeyboardWillShowBlock:(ANKeyboardObserveBlock)willShowBlock
      keyboardWillHideBlock:(ANKeyboardObserveBlock)willHideBlock;
- (void)removeKeyboardObserver:(NSObject *)observer;

@end
