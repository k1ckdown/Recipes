//
//  TextFieldType.swift
//  Recipes
//
//  Created by Ivan Semenov on 24.07.2023.
//

import Foundation

enum PersonalInfoTextFieldType: Int {
    case username
    case email
    
    var placeholder: String {
        switch self {
        case .email:
            return "Email"
        case .username:
            return "Username"
        }
    }
}
