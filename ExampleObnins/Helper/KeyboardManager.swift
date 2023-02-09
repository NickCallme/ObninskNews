//
//  KeyboardManager.swift
//  ExampleObninsk
//
//  Created by Nikita Kolmykov on 02.02.2023.
//

import Foundation
import UIKit

protocol KeyboardHandler: AnyObject {
    var bottomConstraint: NSLayoutConstraint! { get set }
    var observerInput: UIView? { get set }
    
    func keyboardWillShow(_ notification: Notification)
    func keyboardWillHide(_ notification: Notification)
    func startObservingKeyboardChanges()
    func stopObservingKeyboardChanges()
}


extension KeyboardHandler where Self: UIViewController {

    func startObservingKeyboardChanges() {

        // NotificationCenter observers
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
          self?.keyboardWillShow(notification)
        }

        // Deal with rotations
//        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil) { [weak self] notification in
//          self?.keyboardWillShow(notification)
//        }

        // Deal with keyboard change (emoji, numerical, etc.)
//        NotificationCenter.default.addObserver(forName: UITextInputMode.currentInputModeDidChangeNotification, object: nil, queue: nil) { [weak self] notification in
//          self?.keyboardWillShow(notification)
//        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
          self?.keyboardWillHide(notification)
        }
    }


    func keyboardWillShow(_ notification: Notification) {
        

        let verticalPadding: CGFloat = 150 // Padding between the bottom of the view and the top of the keyboard
        
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight = value.cgRectValue.height

      // Here you could have more complex rules, like checking if the textField currently selected is actually covered by the keyboard, but that's out of this scope.
        self.bottomConstraint.constant = keyboardHeight + verticalPadding

        UIView.animate(withDuration: 0.1, animations: { [self] () -> Void in
            
            // Высчитываем положение input  относительно superview
            let frame = (self.view.convert(observerInput!.frame, to: observerInput!.superview))
            
            // Растояние от низа view до низа input
            let bottomViewToBottomInput = view.frame.maxY + frame.minY
            
            // Поднять инпут над клавиатурой
            let heightForView = (keyboardHeight + verticalPadding) - bottomViewToBottomInput
            
            if bottomViewToBottomInput <= (keyboardHeight + verticalPadding) { self.view.frame.origin.y -= heightForView }
      })
  }


  func keyboardWillHide(_ notification: Notification) {
      self.view.frame.origin.y = 0
      self.bottomConstraint.constant = 0

      UIView.animate(withDuration: 0.1, animations: { () -> Void in
          self.view.layoutIfNeeded()
      })
  }


  func stopObservingKeyboardChanges() {
      NotificationCenter.default.removeObserver(self)
  }
}


// MARK: EXTENSION FOR TEXT FIELD & TEXT VIEW

// Добавление таббара для текстового поля

extension UITextField {
    
    func addDoneButtonToKeyboard(myAction: Selector?) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        doneToolbar.isTranslucent = true
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: myAction)
        
        let done = UIBarButtonItem(title: "Готово", style: .done, target: self, action: myAction)
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
}

extension UITextView {
    
    func addDoneButtonToKeyboard(myAction: Selector?) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        doneToolbar.isTranslucent = true
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let done = UIBarButtonItem(title: "Готово", style: .done, target: self, action: myAction)
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
}
