//
//  LoginTextFieldStyle.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import UIKit

enum LoginTextFieldStyle {
    case username
    case email
    case password
    case confirmPassword
    
    var placeholder: String {
        switch self {
        case .username:
            return "Username"
        case .email:
            return "Email"
        case .password:
            return "Password"
        case .confirmPassword:
            return "Confirm Password"
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        default:
            return .default
        }
    }
    
    var isSecureTextEntry: Bool {
        switch self {
        case .password, .confirmPassword:
            return true
        default:
            return false
        }
    }
    
    var image: UIImage? {
        let imageConfig = UIImage.SymbolConfiguration(weight: .bold)
        
        switch self {
        case .username:
            return UIImage(.personFill, withConfiguration: imageConfig)
        case .email:
            return UIImage(.envelopeFill, withConfiguration: imageConfig)
        case .password, .confirmPassword:
            return UIImage(.lock, withConfiguration: imageConfig)
        }
    }
}
