//
//  AuthService.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthService {
    
    private let auth = Auth.auth()
    private let database = Firestore.firestore()
    
    private enum UserConstants {
        static let collecton = "users"
        
        enum Keys {
            static let id = "id"
            static let email = "email"
            static let username = "username"
        }
    }
    
    func getUserId() -> String? {
        return auth.currentUser?.uid
    }
    
    func getCurrentUser(completion: @escaping (User?) -> Void) {
        guard let uid = auth.currentUser?.uid else {
            completion(nil)
            return
        }
        
        getUser(userId: uid) { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    func userIsSignedIn() -> Bool {
        return auth.currentUser != nil
    }
    
    func logOut(completion: (AuthError?) -> Void) {
        do {
            try auth.signOut()
            completion(nil)
        } catch {
            completion(.failedToLogOut)
        }
        
    }
    
    func logIn(data: AuthLogInData, completion: @escaping (Result<User, AuthError>) -> Void) {
        
        auth.signIn(withEmail: data.email, password: data.password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error as? NSError {
                completion(.failure(feedback(for: error)))
            }
            
            guard let authUser = authResult?.user else {
                print("Auth User not found")
                return
            }
            
            getUser(userId: authUser.uid, completion: completion)
        }
        
    }
    
    func signUp(data: AuthSignUpData, completion: @escaping (Result<User, AuthError>) -> Void) {
        
        if data.password != data.confirmPassword {
            completion(.failure(.passwordsDoNotmatch))
            return
        }
        
        auth.createUser(withEmail: data.email, password: data.password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error as? NSError {
                completion(.failure(feedback(for: error)))
            }
            
            guard let authUser = authResult?.user else { return }
            
            let user = User(id: authUser.uid, username: data.username, email: data.email)
            addUserToDatabase(user: user)
            completion(.success(user))
        }
        
    }
    
}

private extension AuthService {
    
    func addUserToDatabase(user: User) {
        let collectionRef = database.collection(UserConstants.collecton)
        let userInfo = [
            UserConstants.Keys.id: user.id,
            UserConstants.Keys.username: user.username,
            UserConstants.Keys.email: user.email
        ]
        collectionRef.document(user.id).setData(userInfo)
    }
    
    func getUser(userId: String, completion: @escaping (Result<User, AuthError>) -> Void) {
        let collectionRef = database.collection(UserConstants.collecton)
        
        collectionRef.document(userId).getDocument { [weak self] snapshot, error in
            guard let self = self else { return }
            
            if let error = error as NSError? {
                completion(.failure(feedback(for: error)))
            }
            
            guard let data = snapshot?.data() else { return }
            
            let username = data[UserConstants.Keys.username] as? String
            let email = data[UserConstants.Keys.email] as? String
            
            let user = User(id: userId, username: username ?? "Not Found", email: email ?? "Not found")
            completion(.success(user))
        }
    }
    
    func feedback(for error: NSError) -> AuthError {
        switch AuthErrorCode.Code(rawValue: error.code) {
        case .invalidEmail:
            return .invalidEmail
        case .userNotFound:
            return .userNotFound
        case .tooManyRequests:
            return .tooManyRequests
        case .wrongPassword:
            return .wrongPassword
        case .weakPassword:
            return .weakPassword
        default:
            return .requestFailed
        }
    }
    
}

