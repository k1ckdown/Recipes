//
//  HomeRouter.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit

final class HomeRouter {
    
    private weak var view: HomeViewController?
    
    init(view: HomeViewController?) {
        self.view = view
    }
    
}

extension HomeRouter: HomeRouterInput {
    
    func showMealDetail(mealId: String) {
        let viewController = MealDetailAssembly.assemble(argument: mealId)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
