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
        setupWindow()

        let showCreateRecipeHandler: (() -> Void) = { [weak self] in
            self?.showCreateRecipe()
        }
        mainTabBarController.showCreateRecipeHandler = showCreateRecipeHandler

        showMainTabBar()
    }
}

private extension AppRouter {
    
    func showMainTabBar() {
        let mainTabBarRouter = MainTabBarRouter(tabBarController: mainTabBarController)
        mainTabBarRouter.start()
    }

    func showCreateRecipe() {
        let createRecipeScene: CreateRecipeViewController = DIContainer.shared.resolve()
        mainTabBarController.present(createRecipeScene, animated: true)
    }

    func setupWindow() {
        window.overrideUserInterfaceStyle = .dark
        window.rootViewController = mainTabBarController
        window.makeKeyAndVisible()
    }

}
