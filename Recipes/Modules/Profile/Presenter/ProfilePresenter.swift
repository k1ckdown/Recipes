//
//  ProfilePresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import Foundation

final class ProfilePresenter {
    
    private(set) var editButtonTitle = "Edit"
    
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
    
    func didTapOnMyRecipesButton() {
        
    }
    
    func didTapOnPersonalInfoButton() {
        router.showPersonalInfoScene()
    }
    
    func didTapOnEditProfilePictureButton() {
        view?.showImagePicker()
    }
    
    func didTapOnLogOutButton() {
        interactor.logOut { error in
            if let error = error {
                router.presentErrorAlert(with: error.description)
            } else {
                user = nil
                view?.hideContent()
            }
        }
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
            self.view?.hideLoader()
            if let user = user {
                self.user = user
                self.view?.showContent()
                self.updateProfileInfo()
            } else {
                self.view?.hideContent()
            }
        }
    }
    
}
