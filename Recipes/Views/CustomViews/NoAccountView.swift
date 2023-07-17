//
//  NoAccountView.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import UIKit

final class NoAccountView: UIView {
    
    var completionHandler: (() -> Void)?
    
    private let imageView = UIImageView()
    private let logInButton = UIButton()
    private let promptLabel = UILabel()
    
    private enum Constants {
        
            enum ImageView {
                static let insetTop = 50
                static let insetSide = 40
                static let multiplierHeight = 0.5
            }
            
            enum PromptLabel {
                static let insetTop = 20
                static let numberOfLines = 0
                static let text = "You need to log in to your account"
            }
            
            enum LogInButton {
                static let height = 50
                static let insetTop = 15
                static let insetSide = 30
                static let title = "Log In"
                static let cornerRadius: CGFloat = 20
            }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func handleLogInButton() {
        completionHandler?()
    }
    
    private func setup() {
        setupSuperView()
        setupImageView()
        setupPromptLabel()
        setupLogInButton()
    }
    
    private func setupSuperView() {
        backgroundColor = .clear
    }
    
    private func setupImageView() {
        addSubview(imageView)
        
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "no-account")
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(Constants.ImageView.insetSide)
            make.height.equalToSuperview().multipliedBy(Constants.ImageView.multiplierHeight)
            make.top.equalToSuperview().offset(Constants.ImageView.insetTop)
        }
    }
    
    private func setupPromptLabel() {
        addSubview(promptLabel)
        
        promptLabel.textColor = .appWhite
        promptLabel.textAlignment = .center
        promptLabel.font = .noAccountPromptLabel
        promptLabel.text = Constants.PromptLabel.text
        promptLabel.numberOfLines = Constants.PromptLabel.numberOfLines
        
        promptLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(Constants.PromptLabel.insetTop)
        }
    }
    
    private func setupLogInButton() {
        addSubview(logInButton)
        
        logInButton.backgroundColor = .appOrange
        logInButton.setTitleColor(.appBlack, for: .normal)
        logInButton.titleLabel?.font = .noAccountLogInButton
        logInButton.setTitle(Constants.LogInButton.title, for: .normal)
        logInButton.layer.cornerRadius = Constants.LogInButton.cornerRadius
        logInButton.addTarget(self, action: #selector(handleLogInButton), for: .touchUpInside)
        
        logInButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.LogInButton.height)
            make.leading.trailing.equalToSuperview().inset(Constants.LogInButton.insetSide)
            make.top.equalTo(promptLabel.snp.bottom).offset(Constants.LogInButton.insetTop)
        }
    }
    
}
