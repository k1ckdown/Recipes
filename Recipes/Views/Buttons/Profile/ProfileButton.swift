//
//  ProfileButton.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import UIKit

final class ProfileButton: UIButton {
    
    private let style: ProfileButtonStyle
    
    private let optionLabel = UILabel()
    private let iconImageView = UIImageView()
    private let chevronImageView = UIImageView()
    
    init(style: ProfileButtonStyle) {
        self.style = style
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupSuperView()
        setupIconImageView()
        setupOptionLabel()
        setupChevronImageView()
    }
    
    private func setupSuperView() {
        backgroundColor = .appBlack
        layer.cornerRadius = 20
    }
    
    private func setupIconImageView() {
        addSubview(iconImageView)
        
        iconImageView.image = style.image
        iconImageView.tintColor = .appWhite
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func setupOptionLabel() {
        addSubview(optionLabel)
        
        optionLabel.text = style.title
        optionLabel.textColor = .appWhite
        optionLabel.font = UIFont.systemFont(ofSize: 18)
        
        optionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(20)
        }
    }
    
    private func setupChevronImageView() {
        addSubview(chevronImageView)
        
        chevronImageView.tintColor = .appWhite
        chevronImageView.image = UIImage(systemName: "chevron.right",
                                         withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(35)
        }
    }
    
}
