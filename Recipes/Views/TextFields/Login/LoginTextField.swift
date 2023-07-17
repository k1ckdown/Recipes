//
//  LoginTextField.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import UIKit

final class LoginTextField: UITextField {
    
    private let style: LoginTextFieldStyle
    
    private enum Constants {
        static let bottomLineFrame = CGRectMake(0.0, 69, 300, 1.0)
        static let leftViewFrame = CGRect(x: 0, y: 0, width: 40, height: 25)
        static let leftImageViewFrame = CGRect(x: 0, y: 0, width: 25, height: 25)
    }
    
    init(style: LoginTextFieldStyle) {
        self.style = style
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupSuperView()
        setupBottomLine()
        setupLeftImageView()
    }
    
    private func setupSuperView() {
        borderStyle = .none
        textColor = .appWhite
        tintColor = .appWhite
        leftViewMode = .always
        attributedPlaceholder = NSAttributedString(
            string: style.placeholder,
            attributes: [.foregroundColor: UIColor.darkGray])
    }
    
    private func setupBottomLine() {
        let bottomLine = CALayer()
        
        bottomLine.frame = Constants.bottomLineFrame
        bottomLine.backgroundColor = UIColor.appWhite?.cgColor
        
        layer.addSublayer(bottomLine)
    }
    
    private func setupLeftImageView() {
        let imageView = UIImageView(frame: Constants.leftImageViewFrame)
        imageView.image = style.image
        
        let view = UIView(frame: Constants.leftViewFrame)
        view.addSubview(imageView)
        
        leftView = view
    }
    
}
