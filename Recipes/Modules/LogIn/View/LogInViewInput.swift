//
//  LogInViewInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import Foundation

protocol LogInViewInput: AnyObject, LoadingDisplayable {
    func applyLoginAppearance()
    func applySignUpAppearance()
}
