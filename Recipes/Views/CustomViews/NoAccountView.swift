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
        
        imageView.image = UIImage(named: "no-account")
        imageView.contentMode = .scaleToFill
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.top.equalToSuperview().offset(50)
        }
    }
    
    private func setupPromptLabel() {
        addSubview(promptLabel)
        
        promptLabel.text = "You need to log in to your account"
        promptLabel.textColor = .appWhite
        promptLabel.textAlignment = .center
        promptLabel.numberOfLines = 0
        promptLabel.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        
        promptLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
    }
    
    private func setupLogInButton() {
        addSubview(logInButton)
        
        logInButton.setTitle("Log In", for: .normal)
        logInButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        logInButton.backgroundColor = .appOrange
        logInButton.layer.cornerRadius = 20
        logInButton.setTitleColor(.appBlack, for: .normal)
        logInButton.addTarget(self, action: #selector(handleLogInButton), for: .touchUpInside)
        
        logInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(promptLabel.snp.bottom).offset(15)
        }
    }
    
}
