//
//  AuthServiceProtocol.swift
//  Recipes
//
//  Created by Ivan Semenov on 21.07.2023.
//

import Foundation

protocol AuthServiceProtocol: AnyObject {
    func getUserId() -> String?
    func userIsSignedIn() -> Bool
    
    func logOut() throws
    func logIn(data: AuthLogInData, completion: @escaping (Result<User, AuthError>) -> Void)
    func signUp(data: AuthSignUpData, completion: @escaping (Result<User, AuthError>) -> Void)
}
