//
//  ProfileInteractorInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import Foundation

protocol ProfileInteractorInput: AnyObject {
    func logOut()
    func updateFavorites()
    func userIsSignedIn() -> Bool
    func getLoggedUser(completion: @escaping (User?) -> Void)
}
