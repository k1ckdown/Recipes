//
//  ProfileRouter.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import UIKit

final class ProfileRouter: Router {
    
    weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
}

// MARK: - ProfileRouterInput

extension ProfileRouter: ProfileRouterInput {
    
    func showLogInScene() {
        let logInScene: LogInViewController = DIContainer.shared.resolve()
        view?.navigationController?.pushViewController(logInScene, animated: true)
    }
    
    func showPersonalInfoScene() {
        let personalInfoScene: PersonalInfoViewController = DIContainer.shared.resolve()
        view?.navigationController?.pushViewController(personalInfoScene, animated: true)
    }
    
}
