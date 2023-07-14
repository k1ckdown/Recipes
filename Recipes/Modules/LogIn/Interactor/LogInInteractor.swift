//
//  LogInInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import Foundation

final class LogInInteractor {
    
    weak var output: LogInInteractorOutput?
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
}

// MARK: - LogInInteractorInput

extension LogInInteractor: LogInInteractorInput {
    
    func logIn(data: AuthLogInData) {
        authService.logIn(data: data) { result in
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func signUp(data: AuthSignUpData) {
        authService.signUp(data: data) { result in
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
