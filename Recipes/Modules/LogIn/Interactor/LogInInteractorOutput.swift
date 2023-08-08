//
//  LogInInteractorOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import Foundation

protocol LogInInteractorOutput: AnyObject {
    func loginSuccess()
    func loginFailure(errorMessage: String)
    
    func signUpSuccess()
    func signUpFailure(errorMessage: String)
}
