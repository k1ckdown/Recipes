//
//  LogInViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import UIKit
import SnapKit

final class LogInViewController: UIViewController, Keyboardable {
    
    var output: LogInViewOutput!
 
    private(set) var loadingView = LoadingView()
    private let contentView = UIView()
    
    private let divider = Divider()
    private let logInLabel = UILabel()
    private let errorLabel = UILabel()
    
    private let textFieldsStackView = UIStackView()
    private let loginButtonsStackView = UIStackView()
    private let loginProviderButtonsStackView = UIStackView()
    
    private let logInButton = UIButton(type: .system)
    private let logInAppleButton = LoginProviderButton(style: .apple)
    private let logInGoogleButton = LoginProviderButton(style: .google)
    
    private let emailTextField = LoginTextField(style: .email)
    private let usernameTextField = LoginTextField(style: .username)
    private let passwordTextField = LoginTextField(style: .password)
    private let confirmPasswordTextField = LoginTextField(style: .confirmPassword)
    
    private let promptLabel = UILabel()
    private let promptButton = UIButton(type: .system)
    
    private var logInLabelTopConstraint: Constraint?
    private var loginButtonsStackViewConstraint: Constraint?
    private var textFieldsStackViewHeightConstraint: Constraint?
    
    private enum Constants {
        
            static let stateAnimateDuration = 0.4
            
            enum LogInLabel {
                static let insetTop = 50
            }
            
            enum TextFieldsStackView {
                static let insetTop = 30
                static let primaryHeight = 200
                static let secondaryHeight = 350
                static let multiplierWidth = 0.8
                static let spacing: CGFloat = 15
            }
            
            enum LoginButtonsStackView {
                static let insetTop = 12
                static let insetSide = 30
                static let primaryHeight = 180
                static let secondaryHeight = 50
                static let spacing: CGFloat = 10
            }
        
            enum LoginProviderButtonsStackView {
                static let spacing: CGFloat = 20
            }
            
            enum LogInButton {
                static let cornerRadius: CGFloat = 10
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
        setupObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.showTabBar()
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc
    private func handleLogInAppleButton() {
        output.didTapOnLogInAppleButton()
    }
    
    @objc
    private func handleLogInGoogleButton() {
        output.didTapOnLogInGoogleButton()
    }
    
    @objc
    private func handlePromptButton() {
        output.didTapOnPromptButton()
    }
    
    @objc
    private func handleLogInButton() {
        view.endEditing(true)
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
        setupLoginButtonsStackView()
        setupLogInButton()
        setupDivider()
        setupLoginProviderButtonsStackView()
        setupLogInAppleButton()
        setupLogInGoogleButton()
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
            logInLabelTopConstraint = make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.LogInLabel.insetTop).constraint
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
            textFieldsStackViewHeightConstraint =  make.height.equalTo(Constants.TextFieldsStackView.primaryHeight).constraint
        }
    }
    
    private func setupUsernameTextField() {
        textFieldsStackView.addArrangedSubview(usernameTextField)
        usernameTextField.delegate = self
        usernameTextField.isHidden = true
    }
    
    private func setupEmailTextField() {
        textFieldsStackView.addArrangedSubview(emailTextField)
        emailTextField.delegate = self
    }
    
    private func setupPasswordTextField() {
        textFieldsStackView.addArrangedSubview(passwordTextField)
        passwordTextField.delegate = self
    }
    
    private func setupConfirmPasswordTextField() {
        textFieldsStackView.addArrangedSubview(confirmPasswordTextField)
        confirmPasswordTextField.delegate = self
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
    
    private func setupLoginButtonsStackView() {
        contentView.addSubview(loginButtonsStackView)
        
        loginButtonsStackView.axis = .vertical
        loginButtonsStackView.distribution = .fillEqually
        loginButtonsStackView.backgroundColor = .clear
        loginButtonsStackView.spacing = Constants.LoginButtonsStackView.spacing
        
        loginButtonsStackView.snp.makeConstraints { make in
            loginButtonsStackViewConstraint = make.height.equalTo(Constants.LoginButtonsStackView.primaryHeight).constraint
            make.leading.trailing.equalToSuperview().inset(Constants.LoginButtonsStackView.insetSide)
            make.top.equalTo(errorLabel.snp.bottom).offset(Constants.LoginButtonsStackView.insetTop)
        }
    }
    
    private func setupLogInButton() {
        loginButtonsStackView.addArrangedSubview(logInButton)
        
        logInButton.setTitleColor(.appWhite, for: .normal)
        logInButton.backgroundColor = .appBlack
        logInButton.titleLabel?.font = .logInButton
        logInButton.layer.cornerRadius = Constants.LogInButton.cornerRadius
        logInButton.addTarget(self, action: #selector(handleLogInButton), for: .touchUpInside)
    }
    
    private func setupDivider() {
        loginButtonsStackView.addArrangedSubview(divider)
        divider.titleLabel = output.dividerTitle
    }
    
    private func setupLoginProviderButtonsStackView() {
        loginButtonsStackView.addArrangedSubview(loginProviderButtonsStackView)
        
        loginProviderButtonsStackView.axis = .horizontal
        loginProviderButtonsStackView.distribution = .fillEqually
        loginProviderButtonsStackView.spacing = Constants.LoginProviderButtonsStackView.spacing
    }
    
    private func setupLogInAppleButton() {
        loginProviderButtonsStackView.addArrangedSubview(logInAppleButton)
        logInAppleButton.addTarget(self, action: #selector(handleLogInAppleButton), for: .touchUpInside)
    }
    
    private func setupLogInGoogleButton() {
        loginProviderButtonsStackView.addArrangedSubview(logInGoogleButton)
        logInGoogleButton.addTarget(self, action: #selector(handleLogInGoogleButton), for: .touchUpInside)
    }
    
    private func setupPromptLabel() {
        contentView.addSubview(promptLabel)
        
        promptLabel.textColor = .appWhite
        promptLabel.font = .promptLabel
        promptLabel.textAlignment = .right
        
        promptLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButtonsStackView.snp.bottom).offset(Constants.PromptLabel.insetTop)
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
            make.top.equalTo(loginButtonsStackView.snp.bottom).offset(Constants.PromptButton.insetTop)
        }
    }
    
    private func setupObservers() {
        registerKeyboardWillHideNotification { [weak self] in
            guard let self = self else { return }
            
            view.layoutIfNeeded()
            logInLabelTopConstraint?.update(offset: Constants.LogInLabel.insetTop)
            view.layoutIfNeeded()
        }
        
        registerKeyboardWillShowNotification { [weak self] keyboardFrame in
            guard
                let self = self,
                keyboardFrame.minY < textFieldsStackView.frame.maxY
            else { return }
            
            view.layoutIfNeeded()
            let neededSpace = textFieldsStackView.frame.maxY - keyboardFrame.minY
            logInLabelTopConstraint?.update(inset: -neededSpace)
            view.layoutIfNeeded()
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
        divider.isHidden = false
        loginProviderButtonsStackView.isHidden = false
        
        textFieldsStackViewHeightConstraint?.update(offset: Constants.TextFieldsStackView.primaryHeight)
        loginButtonsStackViewConstraint?.update(offset: Constants.LoginButtonsStackView.primaryHeight)
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
        divider.isHidden = true
        loginProviderButtonsStackView.isHidden = true
        
        textFieldsStackViewHeightConstraint?.update(offset: Constants.TextFieldsStackView.secondaryHeight)
        loginButtonsStackViewConstraint?.update(offset: Constants.LoginButtonsStackView.secondaryHeight)
        animate(with: .transitionCurlDown)
        
        logInLabel.text = output.signUpLogInLabelText
        logInButton.setTitle(output.signUpLogInButtonTitle, for: .normal)
        promptLabel.text = output.signUpPromptLabelText
        promptButton.setTitle(output.signUpPromptButtonTitle, for: .normal)
    }
    
}

// MARK: - UITextFieldDelegate

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
