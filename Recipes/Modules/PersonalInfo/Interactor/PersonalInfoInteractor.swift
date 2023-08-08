//
//  PersonalInfoInteractor.swift
//  Recipes
//
//  Created by Ivan Semenov on 22.07.2023.
//

import Foundation

final class PersonalInfoInteractor {
    
    weak var output: PersonalInfoInteractorOutput?
    
    private var user: User?
    private var draftUser: User?
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
}

// MARK: - PersonalInfoInteractorInput

extension PersonalInfoInteractor: PersonalInfoInteractorInput {
    
    func updateSex(_ sex: Sex?) {
        draftUser?.sex = sex
    }
    
    func updateEmail(_ email: String) {
        draftUser?.email = email
    }
    
    func updateUsername(_ name: String) {
        draftUser?.username = name
    }
    
    func updateDateOfBirth(_ date: Date) {
        draftUser?.dateOfBirth = date
    }
    
    func retrieveUser() {
        userRepository.getUser { result in
            switch result {
            case .success(let user):
                self.user = user
                self.draftUser = user
                self.output?.didRetrieveUser(user)
            case .failure(let error):
                self.output?.onError(message: error.description)
            }
        }
    }
    
    func saveUserChanges() {
        guard let draftUser = draftUser else { return }
        
        userRepository.updateUser(draftUser) { error in
            if let error = error {
                self.draftUser = self.user
                self.output?.onError(message: error.description)
            } else {
                self.user = self.draftUser
            }
            
            guard let user = self.user else { return }
            self.output?.didRetrieveUser(user)
        }
    }
    
}

