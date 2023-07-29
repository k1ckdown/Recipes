//
//  PersonalInfoRouter.swift
//  Recipes
//
//  Created by Ivan Semenov on 22.07.2023.
//

import UIKit

final class PersonalInfoRouter: Router {
    
    weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
}

// MARK: - PersonalInfoRouterInput

extension PersonalInfoRouter: PersonalInfoRouterInput {
    
}
