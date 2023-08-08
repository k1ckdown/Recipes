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
        view?.showLoader()
        interactor.retrieveLoggedUser()
    }
    
    func didTapOnLogIn() {
        router.showLogInScene()
    }
    
    func didTapOnLogOutButton() {
        interactor.logOut()
    }
    
    
    func didTapOnMyRecipesButton() {
        
    }
    
    func didTapOnPersonalInfoButton() {
        router.showPersonalInfoScene()
    }
    
    func didTapOnEditProfilePictureButton() {
        view?.showImagePicker()
    }
    
    func didUpdateProfilePicture(_ data: Data) {
        interactor.updateProfilePicture(data: data)
    }
    
}

// MARK: - ProfileInteractorOutput

extension ProfilePresenter: ProfileInteractorOutput {
    
    func loginFailure() {
        view?.hideContent()
    }
    
    func logoutFailure(errorMessage: String) {
        router.presentErrorAlert(with: errorMessage)
    }
    
    func logoutSuccess() {
        view?.hideContent()
        view?.resetProfilePicture()
    }
    
    func didRetrieveLoggedUser(_ user: User) {
        view?.hideLoader()
        view?.showContent()
        view?.updateUsername(user.username)
        if let pictureUrl = user.pictureUrl {
            view?.updateProfilePicture(pictureUrl)
        }
    }
    
}
