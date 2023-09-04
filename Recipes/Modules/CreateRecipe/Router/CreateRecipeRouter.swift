//
//  CreateRecipeRouter.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.09.2023.
//

import UIKit

final class CreateRecipeRouter: Router {

    weak var view: UIViewController?

    init(view: UIViewController) {
        self.view = view
    }

}

// MARK: - CreateRecipeRouterInput

extension CreateRecipeRouter: CreateRecipeRouterInput {
    
}
