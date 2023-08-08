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
    private let usersCollectionName = "users"
    
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }

}

extension AuthService: AuthServiceProtocol {
    
    func getUserId() -> String? {
        return auth.currentUser?.uid
    }
    
    func userIsSignedIn() -> Bool {
        return auth.currentUser != nil
    }
    
    func logOut() throws {
        do {
            try auth.signOut()
        } catch {
            throw AuthError.failedToLogOut
        }
    }
    
    func logIn(data: AuthLogInData, completion: @escaping (Result<User, AuthError>) -> Void) {
        
        auth.signIn(withEmail: data.email, password: data.password) { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error as? NSError {
                completion(.failure(AuthError.feedback(for: error)))
                return
            }
            
            userRepository.getUser(completion: completion)
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
                completion(.failure(AuthError.feedback(for: error)))
            }
            
            guard let authUser = authResult?.user else { return }
            
            let user = User(id: authUser.uid, username: data.username, email: data.email)
            userRepository.saveUser(user)
            completion(.success(user))
        }
        
    }
    
}
