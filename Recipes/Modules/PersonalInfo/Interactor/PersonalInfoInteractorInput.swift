//
//  PersonalInfoInteractorInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 22.07.2023.
//

import Foundation

protocol PersonalInfoInteractorInput: AnyObject {
    func updateUserInfo(_ user: User, completion: @escaping (AuthError?) -> Void)
    func getUser(completion: @escaping (Result<User, AuthError>) -> Void)
}
