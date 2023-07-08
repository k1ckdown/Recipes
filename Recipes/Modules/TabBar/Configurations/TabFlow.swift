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
    
    var title: String? {
        nil
    }
    
    var orderNumber: Int {
        return self.rawValue
    }
    
    var image: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house")
        case .search:
            return UIImage(systemName: "magnifyingglass")
        case .favorites:
            return UIImage(systemName: "star")
        case .profile:
            return UIImage(systemName: "person.crop.circle")
        }
    }
}
