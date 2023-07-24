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
    func showImagePicker()
    func resetProfilePicture()
    func updateUsername(_ username: String)
    func updateProfilePicture(_ url: String)
}
