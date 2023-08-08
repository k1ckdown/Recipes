//
//  PersonalInfoInteractorInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 22.07.2023.
//

import Foundation

protocol PersonalInfoInteractorInput: AnyObject {
    func retrieveUser()
    func saveUserChanges()
    
    func updateSex(_ sex: Sex?)
    func updateEmail(_ email: String)
    func updateUsername(_ name: String)
    func updateDateOfBirth(_ date: Date)
}
