//
//  MainTabBarController.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {

    var showCreateRecipeHandler: (() -> Void)? {
        didSet {
            customTabBar.middleButtonHandler = showCreateRecipeHandler
        }
    }
    private let customTabBar = CustomTabBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(customTabBar, forKey: "tabBar")
    }
    
}
