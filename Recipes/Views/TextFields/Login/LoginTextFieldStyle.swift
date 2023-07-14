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
    
    var image: UIImage? {
        let imageConfig = UIImage.SymbolConfiguration(weight: .bold)
        
        switch self {
        case .username:
            return UIImage(systemName: "person.fill", withConfiguration: imageConfig)
        case .email:
            return UIImage(systemName: "envelope.fill", withConfiguration: imageConfig)
        case .password, .confirmPassword:
            return UIImage(systemName: "lock", withConfiguration: imageConfig)
        }
    }
}
