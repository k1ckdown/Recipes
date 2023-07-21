//
//  ProfileInteractorInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import Foundation

protocol ProfileInteractorInput: AnyObject {
    func userIsSignedIn() -> Bool
    func logOut(completion: (AuthError?) -> Void)
    func getLoggedUser(completion: @escaping (User?) -> Void)
}
