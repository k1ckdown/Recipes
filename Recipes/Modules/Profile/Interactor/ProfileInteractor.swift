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
    private let userRepository: UserRepository
    
    init(authService: AuthServiceProtocol, userRepository: UserRepository) {
        self.authService = authService
        self.userRepository = userRepository
    }
}

// MARK: - ProfileInteractorInput

extension ProfileInteractor: ProfileInteractorInput {
    
    func userIsSignedIn() -> Bool {
        authService.userIsSignedIn()
    }
    
    func getLoggedUser(completion: @escaping (Result<User, AuthError>) -> Void) {
        userRepository.getUser(completion: completion)
    }
    
    func logOut(completion: (AuthError?) -> Void) {
        authService.logOut(completion: completion)
    }
    
}
