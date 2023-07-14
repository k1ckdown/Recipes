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
    
    private var db = Firestore.firestore()
    
    func logIn(data: AuthLogInData, completion: @escaping (Result<User, Error>) -> Void) {
        let auth = Auth.auth()
        
        auth.signIn(withEmail: data.email, password: data.password) { [weak self] authResult, error in
            
            if let error = error as? NSError {
                print(error)
                completion(.failure(error))
            }
            
            guard let authUser = authResult?.user else {
                print("Auth User not found")
                return
            }
            
            self?.getUser(userId: authUser.uid, completion: completion)
            
        }
        
    }
    
    func signUp(data: AuthSignUpData, completion: @escaping (Result<User, Error>) -> Void) {
        let auth = Auth.auth()
        
        auth.createUser(withEmail: data.email, password: data.password) { [weak self] authResult, error in
            
            if let error = error as? NSError {
                print(error)
                completion(.failure(error))
            }
            
            guard let authUser = authResult?.user else { return }
            
            let user = User(id: authUser.uid, username: data.username, email: data.email)
            self?.createDataBaseForUser(user: user)
            completion(.success(user))
        }
    }
    
}

private extension AuthService {
    
    func createDataBaseForUser(user: User) {
        let collectionRef = db.collection("users")
        let userInfo = ["id": user.id, "username": user.username, "email": user.email]
        collectionRef.document(user.id).setData(userInfo)
    }
    
    func getUser(userId: String, completion: @escaping (Result<User, Error>) -> Void) {
        let collectionRef = db.collection("users")
        
        collectionRef.document(userId).getDocument { snapshot, error in
            
            if let error = error as NSError? {
                completion(.failure(error))
            }
            
            guard let data = snapshot?.data() else { return }
            
            let username = data["username"] as? String
            let email = data["email"] as? String
            print("USERNAME = \(username ?? "")")
            
            DispatchQueue.main.async {
                let user = User(id: userId, username: username ?? "Not Found", email: email ?? "Not found")
                completion(.success(user))
            }
        }
    }
    
}

