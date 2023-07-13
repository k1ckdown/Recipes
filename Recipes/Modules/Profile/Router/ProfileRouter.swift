//
//  ProfileRouter.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import Foundation

final class ProfileRouter {
    
    private weak var view: ProfileViewController?
    
    init(view: ProfileViewController) {
        self.view = view
    }
    
}

// MARK: - ProfileRouterInput

extension ProfileRouter: ProfileRouterInput {
    
}
