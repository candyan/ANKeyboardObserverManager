ANKeyboardObserverManager
====

ANKeyboardObserverManager make your keyboard observe easier and more flexible.
I
## Installation

To install ANKeyboardObserverManager either:

* use [http://cocoapods.org/](http://cocoapods.org/)

```
pod 'ANKeyboardObserverManager'
```

* or copy __Source/ANKeyboardObserverManager.h__ and __Source/ANKeyboardObserverManager.m__ in your project.

## Usage

Use [ANKeyboardObserverManager sharedManager] directly or alloc/init ANKeyboardObserverManager instance in the class you want to use it.

Then add the observer:

``` objc
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[ANKeyboardObserverManager sharedManager] addKeyboardObserver:self
        withkeyboardWillShowBlock:^(CGRect keyboardEndFrame, NSTimeInterval animateDuration, NSDictionary *info) {
        	your code 
        }
        keyboardWillHideBlock:^(CGRect keyboardEndFrame, NSTimeInterval animateDuration, NSDictionary *info) {
            your code
     }];
}
```

When you do not want to observe the keyboard, remove the observer:
``` objc
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[ANKeyboardObserverManager sharedManager] removeKeyboardObserver:self];
}
```
## Effect

![Alt text](https://raw.githubusercontent.com/candyan/ANKeyboardObserverManager/master/images/demo.gif)