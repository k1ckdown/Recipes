//
//  PersonalInfoInteractorOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 22.07.2023.
//

import Foundation

protocol PersonalInfoInteractorOutput: AnyObject {
    func onError(message: String)
    func didRetrieveUser(_ user: User)
}
