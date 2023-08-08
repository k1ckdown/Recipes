//
//  LogInInteractorInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import Foundation

protocol LogInInteractorInput: AnyObject {
    func logIn(data: AuthLogInData)
    func signUp(data: AuthSignUpData)
}
