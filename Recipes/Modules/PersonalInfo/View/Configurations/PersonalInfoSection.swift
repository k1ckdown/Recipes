//
//  PersonalInfoSection.swift
//  Recipes
//
//  Created by Ivan Semenov on 23.07.2023.
//

import Foundation

enum PersonalInfoSection: Int, CaseIterable {
    case name
    case email
    case sex
    case birthday
    
    var headerTitle: String {
        switch self {
        case .name:
            return "name"
        case .email:
            return "email"
        case .sex:
            return "sex"
        case .birthday:
            return "date of birth"
        }
    }
    
    var heightForRow: CGFloat {
        switch self {
        case .name, .email, .sex:
            return 60
        case .birthday:
            return 230
        }
    }
    
    var heightForFooter: CGFloat {
        switch self {
        case .birthday:
            return 55
        default:
            return 25
        }
    }
}
