//
//  ANKeyboardObserverManager.h
//
//
//  Created by liuyan on 7/22/15.
//
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
