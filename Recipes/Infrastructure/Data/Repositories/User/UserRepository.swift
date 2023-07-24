//
//  UserRepository.swift
//  Recipes
//
//  Created by Ivan Semenov on 24.07.2023.
//

import Foundation
import FirebaseAuth

final class UserRepository {
    
    private let remoteDataSource: UserRemoteDataSourceProtocol
    
    init(remoteDataSource: UserRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
}

extension UserRepository: UserRepositoryProtocol {
    
    func saveUser(_ user: User) {
        remoteDataSource.saveUser(user)
    }
    
    func updateProfilePicture(imageData: Data) {
        remoteDataSource.saveUserPictureToStorage(imageData: imageData)
    }
    
    func updateUser(_ user: User, completion: @escaping (AuthError?) -> Void) {
        remoteDataSource.updateUser(user, completion: completion)
    }
    
    func getUser(completion: @escaping (Result<User, AuthError>) -> Void) {
        remoteDataSource.getUser(completion: completion)
    }
    
}

