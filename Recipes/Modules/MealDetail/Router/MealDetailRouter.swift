//
//  MealDetailRouter.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import UIKit

final class MealDetailRouter: Router {
    
    weak var view: UIViewController?
    
    init(view: UIViewController?) {
        self.view = view
    }
    
}

extension MealDetailRouter: MealDetailRouterInput {
    
    func openUrl(_ url: URL) {
        UIApplication.shared.open(url)
    }
    
}
