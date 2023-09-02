//
//  UserRemoteDataSource.swift
//  Recipes
//
//  Created by Ivan Semenov on 24.07.2023.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
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
        static let imageUrl = "imageUrl"
        static let dateOfBirth = "dateOfBirth"
    }
    
}

extension UserRemoteDataSource: UserRemoteDataSourceProtocol {
    
    func saveUser(_ user: User) {
        let collectionRef = database.collection(usersCollectionName)
        let userInfo = [
            UserKeys.id: user.id,
            UserKeys.username: user.username,
            UserKeys.email: user.email,
        ]
        collectionRef.document(user.id).setData(userInfo)
    }
    
    func getUser(completion: @escaping (Result<User, AuthError>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(.failure(.requestFailed))
            return
        }
        
        let collectionRef = database.collection(usersCollectionName)
        collectionRef.document(uid).getDocument { [weak self] snapshot, error in
            guard self != nil else { return }

            if let error = error as NSError? {
                completion(.failure(AuthError.feedback(for: error)))
                return
            }

            guard let data = snapshot?.data() else { return }

            let username = data[UserKeys.username] as? String
            let email = data[UserKeys.email] as? String
            let dateOfBirth = data[UserKeys.dateOfBirth] as? Timestamp
            let pictureUrl = data[UserKeys.imageUrl] as? String
            var sex: Sex?
            if let sexValue = data[UserKeys.sex] as? Int {
                sex = Sex(rawValue: sexValue)
            }

            let user = User(id: uid,
                            username: username ?? "Not Found",
                            email: email ?? "Not found",
                            dateOfBirth: dateOfBirth?.dateValue(),
                            sex: sex,
                            pictureUrl: pictureUrl)
            completion(.success(user))
        }
    }
    
    func saveUserPictureToStorage(imageData: Data) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = Storage.storage().reference(withPath: uid)
        ref.putData(imageData) { metadata, error in
            if let error = error {
                print(error)
                return
            }
            
            ref.downloadURL { [weak self] url, error in
                if let error = error {
                    print(error)
                    return
                }
                
                guard let imageUrl = url?.absoluteString else { return }
                self?.updateUserPicture(uid: uid, imageUrl: imageUrl)
            }
        }
        
    }
    
    func updateUser(_ user: User, completion: @escaping (AuthError?) -> Void) {
        let documentRef = database.collection(usersCollectionName).document(user.id)
        
        Auth.auth().currentUser?.updateEmail(to: user.email) { error in
            if let error = error as? NSError {
                print(error.localizedDescription)
                completion(AuthError.feedback(for: error))
                return
            }
            
            documentRef.updateData([
                UserKeys.username: user.username,
                UserKeys.email: user.email,
            ])
            
            if let dateOfBirth = user.dateOfBirth {
                documentRef.updateData([UserKeys.dateOfBirth: Timestamp(date: dateOfBirth)])
            }
            
            if let sex = user.sex {
                documentRef.updateData([UserKeys.sex: sex.rawValue])
            }
        }

    }
    
}

// MARK: - Private methods

private extension UserRemoteDataSource {
    
    func updateUserPicture(uid: String, imageUrl: String) {
        let documentRef = database.collection(usersCollectionName).document(uid)
        documentRef.updateData([UserKeys.imageUrl: imageUrl])
    }
    
}

