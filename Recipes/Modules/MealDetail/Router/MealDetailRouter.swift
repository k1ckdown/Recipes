//
//  MealDetailRouter.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import UIKit

final class MealDetailRouter {
    
    private weak var view: MealDetailViewController?
    
    init(view: MealDetailViewController? = nil) {
        self.view = view
    }
    
}

extension MealDetailRouter: MealDetailRouterInput {
    
    func openUrl(_ url: URL) {
        UIApplication.shared.open(url)
    }
    
}
