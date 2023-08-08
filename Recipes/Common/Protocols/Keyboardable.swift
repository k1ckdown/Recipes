//
//  Keyboardable.swift
//  Recipes
//
//  Created by Ivan Semenov on 20.07.2023.
//

import UIKit

protocol Keyboardable {}

extension Keyboardable where Self: UIViewController {
    
    func registerKeyboardWillHideNotification(_ block: (() -> Void)? = nil) {
        let notificationName = UIResponder.keyboardWillHideNotification
        
        NotificationCenter.default.addObserver(forName: notificationName,
                                               object: nil,
                                               queue: nil,
                                               using: { _ in block?() })
    }
    
    func registerKeyboardWillShowNotification(_ block: ((CGRect) -> Void)? = nil) {
        let notificationName = UIResponder.keyboardWillShowNotification
        let notificationBlock: (Notification) -> Void = { notification in
            guard
                let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            else { return }
            block?(keyboardFrame)
        }
        
        NotificationCenter.default.addObserver(forName: notificationName,
                                               object: nil,
                                               queue: nil,
                                               using: notificationBlock)
    }
    
}
