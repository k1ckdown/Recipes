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
        getUser()
    }
    
    func didTapOnLogIn() {
        router.showLogInScene()
    }
    
    func didTapOnMyRecipesButton() {
        
    }
    
    func didTapOnPersonalInfoButton() {
        user = nil
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
                view?.resetProfilePicture()
                view?.hideContent()
            }
        }
    }
    
    func didUpdateProfilePicture(_ data: Data) {
        interactor.updateProfilePicture(data: data)
    }
    
}

// MARK: - ProfileInteractorOutput

extension ProfilePresenter: ProfileInteractorOutput {
    
}

private extension ProfilePresenter {
    
    func updateProfileInfo() {
        guard let user = user else { return }
        view?.updateUsername(user.username)
        
        if let pictureUrl = user.pictureUrl {
            view?.updateProfilePicture(pictureUrl)
        }
    }
    
    func getUser() {
        view?.showLoader()
        interactor.getLoggedUser { result in
            switch result {
            case .success(let user):
                self.user = user
                self.view?.showContent()
                self.updateProfileInfo()
            case .failure:
                self.view?.hideContent()
            }
            self.view?.hideLoader()
        }
    }
    
}
