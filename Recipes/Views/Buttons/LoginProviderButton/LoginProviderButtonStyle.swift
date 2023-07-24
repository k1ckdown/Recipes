//
//  LoginProviderButtonStyle.swift
//  Recipes
//
//  Created by Ivan Semenov on 22.07.2023.
//

import UIKit

enum LoginProviderButtonStyle {
    case apple
    case google
    
    var title: String {
        switch self {
        case .apple:
            return "Apple"
        case .google:
            return "Google"
        }
    }
    
    var logo: UIImage? {
        switch self {
        case .apple:
            return UIImage(.appleLogo)
        case .google:
            return UIImage(.googleLogo)
        }
    }
}
