//
//  HomeRouter.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit

final class HomeRouter {
    
    private weak var view: HomeViewController?
    
    init(view: HomeViewController) {
        self.view = view
    }
    
}

extension HomeRouter: HomeRouterInput {
    
    func showMealDetail(mealId: String) {
        let viewController: MealDetailViewController = DIContainer.shared.resolve(argument: mealId)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showMealList(mealListType: MealListType) {
        let viewController: MealListViewController = DIContainer.shared.resolve(argument: mealListType)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
