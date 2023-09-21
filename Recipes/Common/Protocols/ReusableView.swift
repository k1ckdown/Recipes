//
//  ReusableView.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit

protocol ReusableView: AnyObject {
    
}

extension ReusableView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
extension UICollectionReusableView: ReusableView {}
