//
//  LogInViewOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import Foundation

protocol LogInViewOutput: AnyObject {
    var loginLogInLabelText: String { get }
    var loginLogInButtonTitle: String { get }
    var loginPromptLabelText: String { get }
    var loginPromptButtonTitle: String { get }
    
    var signUpLogInLabelText: String { get }
    var signUpLogInButtonTitle: String { get }
    var signUpPromptLabelText: String { get }
    var signUpPromptButtonTitle: String { get }
    
    func viewDidLoad()
    func didTapOnPromptButton()
    func didTapOnLogInButton(username: String?, email: String?, password: String?)
}
