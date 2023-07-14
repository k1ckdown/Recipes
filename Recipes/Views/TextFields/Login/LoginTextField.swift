//
//  LoginTextField.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import UIKit

final class LoginTextField: UITextField {
    
    private let style: LoginTextFieldStyle
    
    init(style: LoginTextFieldStyle) {
        self.style = style
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRectMake(0.0, 70 - 1, 300, 1.0)
        bottomLine.backgroundColor = UIColor.appWhite?.cgColor
        
        layer.addSublayer(bottomLine)
        borderStyle = .none
        
        textColor = .appWhite
        let imageView = UIImageView(frame: .init(x: 0, y: 0, width: 25, height: 25))
        imageView.image = style.image
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 25))
        view.addSubview(imageView)
        
        leftView = view
        tintColor = .appWhite
        leftViewMode = .always
        
        attributedPlaceholder = NSAttributedString(
            string: style.placeholder,
            attributes: [.foregroundColor: UIColor.darkGray])
        
    }
    
}
