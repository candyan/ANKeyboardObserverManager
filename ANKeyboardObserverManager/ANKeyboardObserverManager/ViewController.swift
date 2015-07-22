//
//  ViewController.swift
//  ANKeyboardObserverManager
//
//  Created by liuyan on 7/22/15.
//  Copyright (c) 2015 Candyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textField = UITextField(frame: CGRectMake(0, self.view.bounds.maxY - 50, self.view.bounds.width, 50))
        self.view.addSubview(self.textField)
        
        self.textField.autoresizingMask = .FlexibleWidth | .FlexibleTopMargin
        self.textField.backgroundColor = UIColor.redColor()
        self.textField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        weak var weakSelf : ViewController! = self
        ANKeyboardObserverManager.sharedManager().addKeyboardObserver(self, withkeyboardWillShowBlock: { (keyboardEndFrame, animateDuration, info) -> Void in
            UIView.animateWithDuration(animateDuration, animations: { () -> Void in
                let newBlockViewRect = CGRectMake(0, weakSelf.view.bounds.height -  keyboardEndFrame.height - 50, weakSelf.view.bounds.width, 50)
                weakSelf.textField.frame = newBlockViewRect;
            })
        }) { (keyboardEndFrame, animateDuration, info) -> Void in
            UIView.animateWithDuration(animateDuration, animations: { () -> Void in
                let newBlockViewRect = CGRectMake(0, weakSelf.view.bounds.height - 50, weakSelf.view.bounds.width, 50)
                weakSelf.textField.frame = newBlockViewRect;
            })
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        ANKeyboardObserverManager.sharedManager().removeKeyboardObserver(self)
    }

}

extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
