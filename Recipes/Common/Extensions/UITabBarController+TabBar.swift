//
//  TabBar+Ext.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import UIKit

extension UITabBarController {
    
    func hideTabBar() {
        guard let view = selectedViewController?.view else { return }
        
        var frame = tabBar.frame
        frame.origin.y = view.frame.height + (frame.height)
        UIView.animate(withDuration: 0.3) {
            self.tabBar.frame = frame
        }
    }

    func showTabBar() {
        guard let view = selectedViewController?.view else { return }
        
        var frame = tabBar.frame
        frame.origin.y = view.frame.height - (frame.height)
        UIView.animate(withDuration: 0.3) {
            self.tabBar.frame = frame
        }
    }
    
}
