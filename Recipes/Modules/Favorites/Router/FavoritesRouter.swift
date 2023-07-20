//
//  FavoritesRouter.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import UIKit

final class FavoritesRouter: Router {
    
    weak var view: UIViewController?
    
    init(view: UIViewController?) {
        self.view = view
    }
    
}

// MARK: - FavoritesRouterInput

extension FavoritesRouter: FavoritesRouterInput {
    
    func showMealDetail(mealId: String) {
        let viewController: MealDetailViewController = DIContainer.shared.resolve(argument: mealId)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showLogInScene() {
        let viewController: LogInViewController = DIContainer.shared.resolve()
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
