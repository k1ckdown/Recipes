//
//  MealDetailAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Foundation

enum MealDetailAssembly {
    
    static func assemble(argument: String) -> MealDetailViewController {
        let viewController = MealDetailViewController()
        let interactor = MealDetailInteractor(mealId: argument)
        let router = MealDetailRouter(view: viewController)
        let presenter = MealDetailPresenter(
            view: viewController,
            interactor: interactor,
            router: router
        )
        
        interactor.output = presenter
        viewController.output = presenter
        
        return viewController
    }
    
}
