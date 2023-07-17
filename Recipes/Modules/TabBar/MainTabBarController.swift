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
        self.tabBar.tintColor = .appOrange
        self.tabBar.barTintColor = .appBackground
        self.tabBar.backgroundColor = .appBackground
        self.tabBar.unselectedItemTintColor = .lightGray
    }
    
}
