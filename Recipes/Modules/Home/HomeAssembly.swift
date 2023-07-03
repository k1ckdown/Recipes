//
//  HomeAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import Foundation

enum HomeAssembly {
    
    static func assemble() -> HomeViewController {
        let viewController = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter(view: viewController)
        let presenter = HomePresenter(
            view: viewController,
            interactor: interactor,
            router: router)
        
        interactor.output = presenter
        viewController.output = presenter
        
        return viewController
    }
    
}
