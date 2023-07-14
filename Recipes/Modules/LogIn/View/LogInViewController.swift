//
//  LogInViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import UIKit
import SnapKit
//import SwiftUI

final class LogInViewController: UIViewController {
    
    var output: LogInViewOutput!
 
    private let logInLabel = UILabel()
    private let logInButton = UIButton(type: .system)
    
    private let textFieldsStackView = UIStackView()
    private let usernameTextField = LoginTextField(style: .username)
    private let passwordTextField = LoginTextField(style: .password)
    private let emailTextField = LoginTextField(style: .email)
    private let confirmPasswordTextField = LoginTextField(style: .confirmPassword)
    
    private let promptLabel = UILabel()
    private let promptButton = UIButton(type: .system)
    
    private var textFieldsStackViewHeightConstaint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        output.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.showTabBar()
    }
    
    @objc
    private func handlePromptButton() {
        output.didTapOnPromptButton()
    }
    
    @objc
    private func handleLogInButton() {
        output.didTapOnLogInButton(username: usernameTextField.text,
                                   email: emailTextField.text,
                                   password: passwordTextField.text)
    }
    
    private func animate(with option: UIView.AnimationOptions) {
        UIView.animate(withDuration: 0.4, delay: 0,  options: [option]) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setup() {
        setupSuperView()
        setupLogInLabel()
        setupTextFieldsStackView()
        setupUsernameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupConfirmPasswordTextField()
        setupLogInButton()
        setupPromptLabel()
        setupPromptButton()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .appBackground
    }
    
    private func setupLogInLabel() {
        view.addSubview(logInLabel)
        
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
        
        textFieldsStackView.spacing = 15
        textFieldsStackView.backgroundColor = .clear
        textFieldsStackView.axis = .vertical
        textFieldsStackView.distribution = .fillEqually
        
        textFieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(logInLabel.snp.bottom).offset(30)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            textFieldsStackViewHeightConstaint =  make.height.equalTo(200).constraint
        }
    }
    
    private func setupUsernameTextField() {
        textFieldsStackView.addArrangedSubview(usernameTextField)
        usernameTextField.isHidden = true
    }
    
    private func setupEmailTextField() {
        textFieldsStackView.addArrangedSubview(emailTextField)
    }
    
    private func setupPasswordTextField() {
        textFieldsStackView.addArrangedSubview(passwordTextField)
    }
    
    private func setupConfirmPasswordTextField() {
        textFieldsStackView.addArrangedSubview(confirmPasswordTextField)
        confirmPasswordTextField.isHidden = true
    }
    
    private func setupLogInButton() {
        view.addSubview(logInButton)
        
        logInButton.layer.cornerRadius = 20
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.backgroundColor = .appBlack
        logInButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        logInButton.addTarget(self, action: #selector(handleLogInButton), for: .touchUpInside)
        
        logInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(130)
            make.top.equalTo(textFieldsStackView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupPromptLabel() {
        view.addSubview(promptLabel)
        
        promptLabel.textColor = .appWhite
        promptLabel.textAlignment = .right
        promptLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        promptLabel.snp.makeConstraints { make in
            make.top.equalTo(logInButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview().offset(-25)
        }
    }
    
    private func setupPromptButton() {
        view.addSubview(promptButton)
        
        promptButton.setTitleColor(.appOrange, for: .normal)
        promptButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        promptButton.addTarget(self, action: #selector(handlePromptButton), for: .touchUpInside)
        
        promptButton.snp.makeConstraints { make in
            make.leading.equalTo(promptLabel.snp.trailing).offset(5)
            make.top.equalTo(logInButton.snp.bottom).offset(24)
        }
    }
    
}

// MARK: - LogInViewInput

extension LogInViewController: LogInViewInput {
    func applyLoginAppearance() {
        usernameTextField.isHidden = true
        confirmPasswordTextField.isHidden = true
        textFieldsStackViewHeightConstaint?.update(offset: 200)
        animate(with: .transitionCurlUp)
        
        logInLabel.text = "Login"
        logInButton.setTitle("LOG IN", for: .normal)
        promptLabel.text = "Don't have an account?"
        promptButton.setTitle("Sign Up", for: .normal)
    }
    
    func applySignUpAppearance() {
        usernameTextField.isHidden = false
        confirmPasswordTextField.isHidden = false
        textFieldsStackViewHeightConstaint?.update(offset: 400)
        animate(with: .transitionCurlDown)
        
        logInLabel.text = "Create Account"
        logInButton.setTitle("SIGN UP", for: .normal)
        promptLabel.text = "Have an account?"
        promptButton.setTitle("Log In", for: .normal)
    }
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        Container().edgesIgnoringSafeArea(.all)
//    }
//
//    struct Container: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> some UIViewController {
//            let vc: LogInViewController = DIContainer.shared.resolve()
//            return UINavigationController(rootViewController: vc)
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//        }
//    }
//}
