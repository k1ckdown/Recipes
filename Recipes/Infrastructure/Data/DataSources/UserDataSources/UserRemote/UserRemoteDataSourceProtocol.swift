//
//  UserRemoteDataSourceProtocol.swift
//  Recipes
//
//  Created by Ivan Semenov on 24.07.2023.
//

import Foundation

protocol UserRemoteDataSourceProtocol {
    func saveUser(_ user: User)
    func saveUserPictureToStorage(imageData: Data)
    func getUser(completion: @escaping (Result<User, AuthError>) -> Void)
    func updateUser(_ user: User, completion: @escaping (AuthError?) -> Void)
}
