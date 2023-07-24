//
//  PersonalInfoInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 22.07.2023.
//

import Foundation

final class PersonalInfoInteractor {
    
    weak var output: PersonalInfoInteractorOutput?
    
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
}

extension PersonalInfoInteractor: PersonalInfoInteractorInput {
    
    func getUser(completion: @escaping (Result<User, AuthError>) -> Void) {
        userRepository.getUser(completion: completion)
    }
    
    func updateUserInfo(_ user: User, completion: @escaping (AuthError?) -> Void) {
        userRepository.updateUser(user, completion: completion)
    }
    
}

