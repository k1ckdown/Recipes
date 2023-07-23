//
//  UserRepository.swift
//  Recipes
//
//  Created by Ivan Semenov on 24.07.2023.
//

import Foundation

final class UserRepository {
    
    private var user: User?
    private let remoteDataSource: UserRemoteDataSource
    
    init(remoteDataSource: UserRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
}

extension UserRepository {
    
    func saveUser(_ user: User) {
        remoteDataSource.saveUser(user)
    }
    
    func updateUser(_ user: User, completion: @escaping (AuthError) -> Void) {
        remoteDataSource.updateUser(user: user, completion: completion)
    }
    
    func getUser(uid: String, completion: @escaping (Result<User, AuthError>) -> Void) {
        if let user = user {
            completion(.success(user))
        } else {
            remoteDataSource.getUser(uid: uid) { [weak self] result in
                switch result {
                case .success(let user):
                    self?.user = user
                    completion(.success(user))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
}

