//
//  LogInViewInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import Foundation

protocol LogInViewInput: AnyObject, LoadingDisplayable {
    func hideError()
    func showError(_ desc: String)
    func applySignUpAppearance()
    func applyLoginAppearance(withAnimation: Bool)
}
