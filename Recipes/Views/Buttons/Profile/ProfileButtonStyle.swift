//
//  ProfileButtonStyle.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import UIKit

enum ProfileButtonStyle {
    case personalInfo
    case myRecipes
    case logout
    
    var shouldShowChevron: Bool {
        switch self {
        case .logout:
            return false
        default:
            return true
        }
    }
    
    var title: String {
        switch self {
        case .personalInfo:
            return "Personal Info"
        case .myRecipes:
            return "My Recipes"
        case .logout:
            return "Log out"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .personalInfo:
            return UIImage(.personCropCircle)
        case .myRecipes:
            return UIImage(.forkKnifeCircle)
        case .logout:
            return UIImage(.doorLeftHandOpen)
        }
    }
}
