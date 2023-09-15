//
//  UITextField+FlexibleSpace.swift
//  Recipes
//
//  Created by Ivan Semenov on 15.09.2023.
//

import UIKit

extension UITextField {

    func addFlexibleSpace(width: CGFloat) {
        let frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height)
        let flexibleSpaceView = UIView(frame: frame)

        self.leftView = flexibleSpaceView
        self.leftViewMode = .always
    }

}
