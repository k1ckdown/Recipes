//
//  LogInViewInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import Foundation

protocol LogInViewInput: AnyObject, LoadingDisplayable {
    func applySignUpAppearance()
    func applyLoginAppearance(withAnimation: Bool)
}
