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
    
    private enum Constants {
        
            enum SuperView {
                static let cornerRadius: CGFloat = 20
            }
            
            enum IconImageView {
                static let size = 40
                static let insetLeading = 20
            }
            
            enum OptionLabel {
                static let insetLeading = 20
            }
            
            enum ChevronImageView {
                static let insetTrailing = 35
            }
        
    }
    
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
        layer.cornerRadius = Constants.SuperView.cornerRadius
    }
    
    private func setupIconImageView() {
        addSubview(iconImageView)
        
        iconImageView.image = style.image
        iconImageView.tintColor = .appWhite
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(Constants.IconImageView.size)
            make.leading.equalToSuperview().offset(Constants.IconImageView.insetLeading)
        }
    }
    
    private func setupOptionLabel() {
        addSubview(optionLabel)
        
        optionLabel.text = style.title
        optionLabel.textColor = .appWhite
        optionLabel.font = .profileOptionLabel
        
        optionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(Constants.OptionLabel.insetLeading)
        }
    }
    
    private func setupChevronImageView() {
        addSubview(chevronImageView)
        
        chevronImageView.tintColor = .appWhite
        chevronImageView.isHidden = !style.shouldShowChevron
        chevronImageView.image = UIImage(.chevronRight,
                                         withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(Constants.ChevronImageView.insetTrailing)
        }
    }
    
}
