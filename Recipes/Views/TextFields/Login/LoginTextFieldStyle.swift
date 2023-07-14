//
//  LoginTextFieldStyle.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import UIKit

enum LoginTextFieldStyle {
    case username
    case password
    
    var placeholder: String {
        switch self {
        case .username:
            return "Username"
        case .password:
            return "Password"
        }
    }
    
    var image: UIImage? {
        let imageConfig = UIImage.SymbolConfiguration(weight: .bold)
        
        switch self {
        case .username:
            return UIImage(systemName: "person.fill", withConfiguration: imageConfig)
        case .password:
            return UIImage(systemName: "lock", withConfiguration: imageConfig)
        }
    }
}
