//
//  ProfileInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import Foundation

final class ProfileInteractor {
    
    weak var output: ProfileInteractorOutput?
    
    private let authService: AuthServiceProtocol
    private let userRepository: UserRepositoryProtocol
    
    init(authService: AuthServiceProtocol, userRepository: UserRepositoryProtocol) {
        self.authService = authService
        self.userRepository = userRepository
    }
}

// MARK: - ProfileInteractorInput

extension ProfileInteractor: ProfileInteractorInput {
    
    func updateProfilePicture(data: Data) {
        userRepository.updateProfilePicture(imageData: data)
    }
    
    func logOut() {
        do {
            try authService.logOut()
            output?.logoutSuccess()
        } catch let error as AuthError {
            output?.logoutFailure(errorMessage: error.description)
        } catch {
            
        }
    }
    
    func retrieveLoggedUser() {
        userRepository.getUser { result in
            switch result {
            case .success(let user):
                self.output?.didRetrieveLoggedUser(user)
            case .failure:
                self.output?.loginFailure()
            }
        }
    }
    
}
