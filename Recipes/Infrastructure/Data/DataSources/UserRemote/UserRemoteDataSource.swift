//
//  UserRemoteDataSource.swift
//  Recipes
//
//  Created by Ivan Semenov on 24.07.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserRemoteDataSource {
    
    private let database = Firestore.firestore()
    private let usersCollectionName = "users"
    
    private enum UserKeys {
        static let id = "id"
        static let sex = "sex"
        static let email = "email"
        static let username = "username"
        static let dateOfBirth = "dateOfBirth"
    }
    
}

extension UserRemoteDataSource {
    
    func saveUser(_ user: User) {
        let collectionRef = database.collection(usersCollectionName)
        let userInfo = [
            UserKeys.id: user.id,
            UserKeys.username: user.username,
            UserKeys.email: user.email
        ]
        collectionRef.document(user.id).setData(userInfo)
    }
    
    func getUser(uid: String, completion: @escaping (Result<User, AuthError>) -> Void) {
        let collectionRef = database.collection(usersCollectionName)

        collectionRef.document(uid).getDocument { [weak self] snapshot, error in
            guard self != nil else { return }

            if let error = error as NSError? {
                completion(.failure(AuthError.feedback(for: error)))
            }

            guard let data = snapshot?.data() else { return }

            let username = data[UserKeys.username] as? String
            let email = data[UserKeys.email] as? String
            let sex = data[UserKeys.sex] as? Sex
            let dateOfBirth = data[UserKeys.dateOfBirth] as? Date

            let user = User(id: uid,
                            username: username ?? "Not Found",
                            email: email ?? "Not found",
                            dateOfBirth: dateOfBirth,
                            sex: sex)
            completion(.success(user))
        }
    }
    
    func updateUser(user: User, completion: @escaping (AuthError) -> Void) {
        let documentRef = database.collection(usersCollectionName).document(user.id)
        
        documentRef.updateData([
            UserKeys.username: user.username,
            UserKeys.email: user.email,
        ])
        
        if let dateOfBirth = user.dateOfBirth {
            documentRef.updateData([UserKeys.dateOfBirth: dateOfBirth])
        }
        
        if let sex = user.sex {
            documentRef.updateData([UserKeys.sex: sex])
        }
    }
    
}

