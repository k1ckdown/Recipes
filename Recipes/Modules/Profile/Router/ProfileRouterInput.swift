//
//  ProfileRouterInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import Foundation

protocol ProfileRouterInput: AnyObject, AlertPresentable {
    func showLogInScene()
    func showPersonalInfoScene()
}
