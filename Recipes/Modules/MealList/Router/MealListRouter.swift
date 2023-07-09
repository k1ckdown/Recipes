//
//  MealListRouter.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

final class MealListRouter {
    
    private weak var view: MealListViewController?
    
    init(view: MealListViewController) {
        self.view = view
    }
}

extension MealListRouter: MealListRouterInput {
    
    func showMealDetail(mealId: String) {
        let viewController: MealDetailViewController = DIContainer.shared.resolve(argument: mealId)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
