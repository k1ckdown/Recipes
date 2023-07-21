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
    private let mealRepository: MealRepositoryProtocol
    
    init(authService: AuthServiceProtocol, mealRepository: MealRepositoryProtocol) {
        self.authService = authService
        self.mealRepository = mealRepository
    }
}

// MARK: - ProfileInteractorInput

extension ProfileInteractor: ProfileInteractorInput {
    
    func userIsSignedIn() -> Bool {
        authService.userIsSignedIn()
    }
    
    func getLoggedUser(completion: @escaping (User?) -> Void) {
        authService.getCurrentUser(completion: completion)
    }
    
    func logOut() {
        authService.logOut { error in
            if let error = error {
                print(error.description)
            }
        }
    }
    
}
