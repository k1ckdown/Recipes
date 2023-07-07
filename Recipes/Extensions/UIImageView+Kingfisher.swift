//
//  UIImageView+Kingfisher.swift
//  Recipes
//
//  Created by Ivan Semenov on 08.07.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(_ urlString: String, placeholder: UIImage? = nil, inset: CGFloat) {
        kf.setImage(with: URL(string: urlString), placeholder: placeholder) { result in
            self.image = try? result.get().image.resizableImage(
                withCapInsets: .init(top: inset, left: inset, bottom: inset, right: inset),
                resizingMode: .stretch
            )
        }
    }
}

