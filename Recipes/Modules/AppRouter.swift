//
//  AppRouter.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit

final class AppRouter {
    
    private let window: UIWindow
    private let mainTabBarController: MainTabBarController
    
    init(window: UIWindow) {
        self.window = window
        mainTabBarController = .init()
    }
    
    func start() {
        window.overrideUserInterfaceStyle = .dark
        window.rootViewController = mainTabBarController
        window.makeKeyAndVisible()
        
        showMainTabBar()
    }
}

private extension AppRouter {
    
    func showMainTabBar() {
        let mainTabBarRouter = MainTabBarRouter(tabBarController: mainTabBarController)
        mainTabBarRouter.start()
    }
    
}
