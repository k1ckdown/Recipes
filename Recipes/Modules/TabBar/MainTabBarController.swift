//
//  MainTabBarController.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .appWhite
        self.tabBar.barTintColor = .appBackground
        self.tabBar.backgroundColor = .appBackground
        self.tabBar.unselectedItemTintColor = .lightGray
    }
    
}
