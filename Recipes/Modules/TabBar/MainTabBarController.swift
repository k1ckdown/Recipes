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
        setValue(CustomTabBar(), forKey: "tabBar")
    }
    
}
