//
//  LogInViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import UIKit
import SnapKit

final class LogInViewController: UIViewController {
    
    var output: LogInViewOutput!
 
    private(set) var loadingView = LoadingView()
    private let contentView = UIView()
    private let errorLabel = UILabel()
    
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
    
    private enum Constants {
        
            static let stateAnimateDuration = 0.4
            
            enum LogInLabel {
                static let insetTop = 50
            }
            
            enum TextFieldsStackView {
                static let insetTop = 30
                static let primaryHeight = 200
                static let secondaryHeight = 400
                static let multiplierWidth = 0.8
                static let spacing: CGFloat = 15
            }
            
            enum LogInButton {
                static let height = 50
                static let width = 130
                static let insetTop = 12
                static let cornerRadius: CGFloat = 20
            }
            
            enum PromptLabel {
                static let insetTop = 30
                static let insetCenterX = -25
            }
            
            enum PromptButton {
                static let insetTop = 24
                static let insetLeading = 5
            }
        
    }
    
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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc
    private func handlePromptButton() {
        output.didTapOnPromptButton()
    }
    
    @objc
    private func handleLogInButton() {
        output.didTapOnLogInButton(username: usernameTextField.text,
                                   email: emailTextField.text,
                                   password: passwordTextField.text,
                                   confirmPassword: confirmPasswordTextField.text)
    }
    
    private func animate(with option: UIView.AnimationOptions) {
        UIView.animate(withDuration: Constants.stateAnimateDuration, delay: 0,  options: [option]) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setup() {
        setupSuperView()
        setupContentView()
        setupLogInLabel()
        setupTextFieldsStackView()
        setupUsernameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupConfirmPasswordTextField()
        setupErrorLabel()
        setupLogInButton()
        setupPromptLabel()
        setupPromptButton()
        setupLoadingView()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .appBackground
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        
        contentView.backgroundColor = .clear
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupLogInLabel() {
        contentView.addSubview(logInLabel)
        
        logInLabel.textColor = .appWhite
        logInLabel.textAlignment = .center
        logInLabel.font = .logInLabel
        
        logInLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.LogInLabel.insetTop)
        }
    }
    
    private func setupTextFieldsStackView() {
        contentView.addSubview(textFieldsStackView)
        
        textFieldsStackView.axis = .vertical
        textFieldsStackView.distribution = .fillEqually
        textFieldsStackView.backgroundColor = .clear
        textFieldsStackView.spacing = textFieldsStackView.spacing
        
        textFieldsStackView.snp.makeConstraints { make in
            make.top.equalTo(logInLabel.snp.bottom).offset(Constants.TextFieldsStackView.insetTop)
            make.width.equalToSuperview().multipliedBy(Constants.TextFieldsStackView.multiplierWidth)
            make.centerX.equalToSuperview()
            textFieldsStackViewHeightConstaint =  make.height.equalTo(Constants.TextFieldsStackView.primaryHeight).constraint
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
    
    private func setupErrorLabel() {
        contentView.addSubview(errorLabel)
        
        errorLabel.isHidden = true
        errorLabel.textColor = .systemRed
        errorLabel.textAlignment = .center
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldsStackView.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupLogInButton() {
        contentView.addSubview(logInButton)
        
        logInButton.setTitleColor(.appWhite, for: .normal)
        logInButton.backgroundColor = .appBlack
        logInButton.titleLabel?.font = .logInButton
        logInButton.layer.cornerRadius = Constants.LogInButton.cornerRadius
        logInButton.addTarget(self, action: #selector(handleLogInButton), for: .touchUpInside)
        
        logInButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.LogInButton.height)
            make.width.equalTo(Constants.LogInButton.width)
            make.top.equalTo(errorLabel.snp.bottom).offset(Constants.LogInButton.insetTop)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupPromptLabel() {
        contentView.addSubview(promptLabel)
        
        promptLabel.textColor = .appWhite
        promptLabel.textAlignment = .right
        promptLabel.font = .promptLabel
        
        promptLabel.snp.makeConstraints { make in
            make.top.equalTo(logInButton.snp.bottom).offset(Constants.PromptLabel.insetTop)
            make.centerX.equalToSuperview().offset(Constants.PromptLabel.insetCenterX)
        }
    }
    
    private func setupPromptButton() {
        contentView.addSubview(promptButton)
        
        promptButton.setTitleColor(.appOrange, for: .normal)
        promptButton.titleLabel?.font = .promptLabel
        promptButton.addTarget(self, action: #selector(handlePromptButton), for: .touchUpInside)
        
        promptButton.snp.makeConstraints { make in
            make.leading.equalTo(promptLabel.snp.trailing).offset(Constants.PromptButton.insetLeading)
            make.top.equalTo(logInButton.snp.bottom).offset(Constants.PromptButton.insetTop)
        }
    }
    
}

// MARK: - LogInViewInput

extension LogInViewController: LogInViewInput {
    
    func hideError() {
        errorLabel.isHidden = true
    }
    
    func showError(_ desc: String) {
        errorLabel.text = desc
        errorLabel.isHidden = false
    }
    
    func showLoader() {
        contentView.isHidden = true
        loadingView.startAnimating()
    }
    
    func hideLoader() {
        contentView.isHidden = false
        loadingView.stopAnimating()
    }
    
    func applyLoginAppearance(withAnimation: Bool = true) {
        usernameTextField.isHidden = true
        confirmPasswordTextField.isHidden = true
        textFieldsStackViewHeightConstaint?.update(offset: Constants.TextFieldsStackView.primaryHeight)
        
        if withAnimation {
            animate(with: .transitionCurlUp)
        }
        
        logInLabel.text = output.loginLogInLabelText
        logInButton.setTitle(output.loginLogInButtonTitle, for: .normal)
        promptLabel.text = output.loginPromptLabelText
        promptButton.setTitle(output.loginPromptButtonTitle, for: .normal)
    }
    
    func applySignUpAppearance() {
        usernameTextField.isHidden = false
        confirmPasswordTextField.isHidden = false
        textFieldsStackViewHeightConstaint?.update(offset: Constants.TextFieldsStackView.secondaryHeight)
        animate(with: .transitionCurlDown)
        
        logInLabel.text = output.signUpLogInLabelText
        logInButton.setTitle(output.signUpLogInButtonTitle, for: .normal)
        promptLabel.text = output.signUpPromptLabelText
        promptButton.setTitle(output.signUpPromptButtonTitle, for: .normal)
    }
    
}
