//
//  ProfileViewOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import Foundation

protocol ProfileViewOutput: AnyObject {
    func viewWillAppear()
    func didTapOnLogIn()
    func didTapOnLogOutButton()
}
