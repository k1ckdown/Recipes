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
    
    func updateUser(_ user: User, completion: @escaping (AuthError?) -> Void) {
        remoteDataSource.updateUser(user, completion: completion)
    }
    
    func getUser(completion: @escaping (Result<User, AuthError>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(.failure(.requestFailed))
            return
        }
        
        remoteDataSource.getUser(uid: uid) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

