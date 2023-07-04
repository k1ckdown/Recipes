//
//  ReuseIdentifier.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import Foundation

protocol ReuseIdentifier: AnyObject {
    
}

extension ReuseIdentifier {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
