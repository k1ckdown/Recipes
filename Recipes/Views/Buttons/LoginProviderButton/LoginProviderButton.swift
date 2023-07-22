//
//  LoginProviderButton.swift
//  Recipes
//
//  Created by Ivan Semenov on 22.07.2023.
//

import UIKit

final class LoginProviderButton: UIButton {
    
    private let style: LoginProviderButtonStyle
    
    private let nameProviderLabel = UILabel()
    private let logoProviderImageView = UIImageView()
    
    private enum Constants {
        
            enum SuperView {
                static let cornerRadius: CGFloat = 10
            }
            
            enum LogoProviderImageView {
                static let size = 20
                static let insetTrailing = 10
            }
        
    }
    
    init(style: LoginProviderButtonStyle) {
        self.style = style
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupSuperView()
        setupNameProviderLabel()
        setupLogoProviderImageView()
    }
    
    private func setupSuperView() {
        backgroundColor = .appBlack
        layer.cornerRadius = Constants.SuperView.cornerRadius
    }
    
    private func setupNameProviderLabel() {
        addSubview(nameProviderLabel)
        
        nameProviderLabel.text = style.title
        nameProviderLabel.textColor = .appWhite
        nameProviderLabel.textAlignment = .center
        nameProviderLabel.font = .nameProviderLabel
        
        nameProviderLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(Constants.LogoProviderImageView.insetTrailing)
        }
    }
    
    private func setupLogoProviderImageView() {
        addSubview(logoProviderImageView)
        
        logoProviderImageView.image = style.logo
        logoProviderImageView.contentMode = .scaleAspectFit
        
        logoProviderImageView.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.LogoProviderImageView.size)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(nameProviderLabel.snp.leading).offset(-Constants.LogoProviderImageView.insetTrailing)
        }
    }

}
