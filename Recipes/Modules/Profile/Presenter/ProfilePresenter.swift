//
//  ProfilePresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import Foundation

final class ProfilePresenter {
    
    private weak var view: ProfileViewInput?
    private let interactor: ProfileInteractorInput
    private let router: ProfileRouterInput
    
    init(
        view: ProfileViewInput,
        interactor: ProfileInteractorInput,
        router: ProfileRouterInput
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - ProfileViewOutput

extension ProfilePresenter: ProfileViewOutput {
    
    func viewDidLoad() {
        view?.hideContent()
    }
    
    func didTapOnLogIn() {
        router.showLogInScene()
    }
    
}

// MARK: - ProfileInteractorOutput

extension ProfilePresenter: ProfileInteractorOutput {
    
}
