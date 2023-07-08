//
//  AppRouter.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit

final class AppRouter {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        showHomeScene()
    }
}

private extension AppRouter {
    func showHomeScene() {
        let homeViewController: HomeViewController = DIContainer.shared.resolve()
        navigationController.setViewControllers([homeViewController], animated: true)
    }
}
