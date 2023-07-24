//
//  UserRepositoryProtocol.swift
//  Recipes
//
//  Created by Ivan Semenov on 24.07.2023.
//

import Foundation

protocol UserRepositoryProtocol {
    func saveUser(_ user: User)
    func updateProfilePicture(imageData: Data)
    func getUser(completion: @escaping (Result<User, AuthError>) -> Void)
    func updateUser(_ user: User, completion: @escaping (AuthError?) -> Void)
}
