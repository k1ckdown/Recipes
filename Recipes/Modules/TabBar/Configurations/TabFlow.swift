//
//  TabFlow.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import UIKit

enum TabFlow: Int, CaseIterable {
    case home
    case search
    case favorites
    case profile
    
    var orderNumber: Int {
        return self.rawValue
    }
    
    var title: String? {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .favorites:
            return "Favorites"
        case .profile:
            return "Profile"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .home:
            return UIImage(.house)
        case .search:
            return UIImage(.magnifyingglass)
        case .favorites:
            return UIImage(.systemHeart)
        case .profile:
            return UIImage(.person)
        }
    }
}
