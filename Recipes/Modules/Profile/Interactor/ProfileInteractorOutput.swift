//
//  ProfileInteractorOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import Foundation

protocol ProfileInteractorOutput: AnyObject {
    func loginFailure()
    func logoutSuccess()
    func logoutFailure(errorMessage: String)
    func didRetrieveLoggedUser(_ user: User)
}
