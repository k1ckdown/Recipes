//
//  SearchRouter.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import UIKit

final class SearchRouter: Router {
    
    weak var view: UIViewController?
    
    init(view: UIViewController?) {
        self.view = view
    }
    
}

// MARK: - SearchRouterInput

extension SearchRouter: SearchRouterInput {
    
    func showMealDetail(mealId: String) {
        let viewController: MealDetailViewController = DIContainer.shared.resolve(argument: mealId)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
    
}


