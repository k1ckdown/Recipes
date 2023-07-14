//
//  ProfileInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import Foundation

final class ProfileInteractor {
    
    weak var output: ProfileInteractorOutput?
    
    private let authService: AuthService
    private let mealRepository: MealRepository
    
    init(authService: AuthService, mealRepository: MealRepository) {
        self.authService = authService
        self.mealRepository = mealRepository
    }
}

// MARK: - ProfileInteractorInput

extension ProfileInteractor: ProfileInteractorInput {
    
    func updateFavorites() {
        mealRepository.updateFavoriteMeals()
    }
    
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
