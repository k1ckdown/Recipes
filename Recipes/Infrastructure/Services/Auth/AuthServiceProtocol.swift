//
//  AuthServiceProtocol.swift
//  Recipes
//
//  Created by Ivan Semenov on 21.07.2023.
//

import Foundation

protocol AuthServiceProtocol {
    func getUserId() -> String?
    func userIsSignedIn() -> Bool
    func logOut(completion: (AuthError?) -> Void)
    func getCurrentUser(completion: @escaping (User?) -> Void)
    func logIn(data: AuthLogInData, completion: @escaping (Result<User, AuthError>) -> Void)
    func signUp(data: AuthSignUpData, completion: @escaping (Result<User, AuthError>) -> Void)
}
