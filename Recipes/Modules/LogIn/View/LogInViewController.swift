//
//  LogInViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import UIKit
import SwiftUI

final class LogInViewController: UIViewController {
    
    var output: LogInViewOutput!
 
    private let logInLabel = UILabel()
    private let logInButton = UIButton(type: .system)
    private let usernameTextField = LoginTextField(style: .username)
    private let passwordTextField = LoginTextField(style: .password)
    private let textFieldsStackView = UIStackView()
    
    private let promptLabel = UILabel()
    private let signUpButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupSuperView()
        setupLogInLabel()
        setupTextFieldsStackView()
        setupUsernameTextField()
        setupPasswordTextField()
        setupLogInButton()
        setupPromptLabel()
        setupSignUpButton()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .appBackground
    }
    
    private func setupLogInLabel() {
        view.addSubview(logInLabel)
        
        logInLabel.text = "Login"
        logInLabel.textColor = .appWhite
        logInLabel.textAlignment = .center
        logInLabel.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        
        logInLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
        }
    }
    
    private func setupTextFieldsStackView() {
        view.addSubview(textFieldsStackView)
        
        textFieldsStackView.spacing = 20
        textFieldsStackView.backgroundColor = .clear
        textFieldsStackView.axis = .vertical
        textFieldsStackView.distribution = .fillEqually
        
        textFieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(logInLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(200)
        }
    }
    
    private func setupUsernameTextField() {
        textFieldsStackView.addArrangedSubview(usernameTextField)
    }
    
    private func setupPasswordTextField() {
        textFieldsStackView.addArrangedSubview(passwordTextField)
    }
    
    private func setupLogInButton() {
        view.addSubview(logInButton)
        
        logInButton.setTitle("LOG IN", for: .normal)
        logInButton.layer.cornerRadius = 20
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.backgroundColor = .appBlack
        logInButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        logInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(130)
            make.top.equalTo(textFieldsStackView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupPromptLabel() {
        view.addSubview(promptLabel)
        
        promptLabel.text = "Don't have an account?"
        promptLabel.textColor = .appWhite
        promptLabel.textAlignment = .right
        promptLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        promptLabel.snp.makeConstraints { make in
            make.top.equalTo(logInButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview().offset(-25)
        }
    }
    
    private func setupSignUpButton() {
        view.addSubview(signUpButton)
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.appOrange, for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        signUpButton.snp.makeConstraints { make in
            make.leading.equalTo(promptLabel.snp.trailing).offset(5)
            make.top.equalTo(logInButton.snp.bottom).offset(24)
        }
    }
    
}

// MARK: - LogInViewInput

extension LogInViewController: LogInViewInput {
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }

    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            let vc: LogInViewController = DIContainer.shared.resolve()
            return UINavigationController(rootViewController: vc)
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

        }
    }
}
