//
//  ProfileViewInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import Foundation

protocol ProfileViewInput: AnyObject, LoadingDisplayable {
    func showContent()
    func hideContent()
    func updateUsername(_ username: String)
}
