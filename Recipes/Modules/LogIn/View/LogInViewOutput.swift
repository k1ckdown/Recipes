//
//  LogInViewOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import Foundation

protocol LogInViewOutput: AnyObject {
    func viewDidLoad()
    func didTapOnPromptButton()
    func didTapOnLogInButton(username: String?, email: String?, password: String?)
}
