//
//  LogInInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import Foundation

final class LogInInteractor {
    
    weak var output: LogInInteractorOutput?
    
    private let authService: AuthServiceProtocol
    private let mealRepository: MealRepositoryProtocol
    
    init(authService: AuthServiceProtocol, mealRepository: MealRepositoryProtocol) {
        self.authService = authService
        self.mealRepository = mealRepository
    }
    
}

// MARK: - LogInInteractorInput

extension LogInInteractor: LogInInteractorInput {
    
    func logIn(data: AuthLogInData) {
        authService.logIn(data: data) { result in
            switch result {
            case .success:
                self.output?.loginSuccess()
                self.mealRepository.updateFavoriteMeals()
            case .failure(let error):
                self.output?.loginFailure(errorMessage: error.description)
            }
        }
    }
    
    func signUp(data: AuthSignUpData) {
        authService.signUp(data: data) { result in
            switch result {
            case .success:
                self.output?.signUpSuccess()
            case .failure(let error):
                self.output?.signUpFailure(errorMessage: error.description)
            }
        }
    }
    
}
