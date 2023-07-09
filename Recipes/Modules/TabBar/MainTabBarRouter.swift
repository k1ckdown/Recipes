//
//  MainTabBarRouter.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import UIKit

final class MainTabBarRouter {
    
    private let tabBarController: MainTabBarController
    
    init(tabBarController: MainTabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let viewControllers = TabFlow.allCases.map { getTab($0) }
        tabBarController.setViewControllers(viewControllers, animated: true)
        selectTab(.home)
    }
    
    func selectTab(_ flow: TabFlow) {
        tabBarController.selectedIndex = flow.orderNumber
    }
    
    private func getTab(_ flow: TabFlow) -> UIViewController {
        let navigationController = UINavigationController()
        
        switch flow {
        case .home:
            let home: HomeViewController = DIContainer.shared.resolve()
            navigationController.setViewControllers([home], animated: true)
        case .search:
            let searchScene: SearchViewController = DIContainer.shared.resolve()
            navigationController.setViewControllers([searchScene], animated: true)
        default: break
        }
        
        navigationController.tabBarItem = .init(title: flow.title,
                                                image: flow.image,
                                                tag: flow.orderNumber)
        
        return navigationController
    }
    
}
