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
    
    private var user: User?
    
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
    
    func viewWillAppear() {
        guard user == nil else { return }
        
        view?.showLoader()
        getUser()
    }
    
    func didTapOnLogIn() {
        router.showLogInScene()
    }
    
    func didTapOnLogOutButton() {
        user = nil
        interactor.logOut()
        view?.hideContent()
    }
    
}

// MARK: - ProfileInteractorOutput

extension ProfilePresenter: ProfileInteractorOutput {
    
}

private extension ProfilePresenter {
    
    func updateProfileInfo() {
        guard let user = user else { return }
        view?.updateUsername(user.username)
    }
    
    func getUser() {
        interactor.getLoggedUser { user in
            if let user = user {
                self.user = user
                self.view?.showContent()
                self.updateProfileInfo()
                self.interactor.updateFavorites()
            } else {
                self.view?.hideContent()
            }
            self.view?.hideLoader()
        }
    }
    
}
