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
    
    func logIn(data: AuthLogInData, completion: @escaping (Result<User, AuthError>) -> Void) {
        authService.logIn(data: data, completion: completion)
    }
    
    func signUp(data: AuthSignUpData, completion: @escaping (Result<User, AuthError>) -> Void) {
        authService.signUp(data: data, completion: completion)
    }
    
}
