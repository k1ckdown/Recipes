//
//  ProfileViewOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import Foundation

protocol ProfileViewOutput: AnyObject {
    var editButtonTitle: String { get }
    
    func viewWillAppear()
    func didUpdateProfilePicture(_ data: Data)
    
    func didTapOnLogIn()
    func didTapOnLogOutButton()
    func didTapOnMyRecipesButton()
    func didTapOnPersonalInfoButton()
    func didTapOnEditProfilePictureButton()
}
