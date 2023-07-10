//
//  SearchRouter.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

final class SearchRouter {
    
    private weak var view: SearchViewController?
    
    init(view: SearchViewController? = nil) {
        self.view = view
    }
    
}

extension SearchRouter: SearchRouterInput {
    
    func showMealDetail(mealId: String) {
        let viewController: MealDetailViewController = DIContainer.shared.resolve(argument: mealId)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
    
}


