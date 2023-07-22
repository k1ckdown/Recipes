//
//  LogInPresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import Foundation

final class LogInPresenter {
    
    private(set) var dividerTitle = "Or login with"
    private(set) var loginLogInLabelText = "Login"
    private(set) var loginLogInButtonTitle = "LOG IN"
    private(set) var loginPromptButtonTitle = "Sign Up"
    private(set) var loginPromptLabelText = "Don't have an account?"
    
    private(set) var signUpLogInLabelText = "Create Account"
    private(set) var signUpLogInButtonTitle = "SIGN UP"
    private(set) var signUpPromptButtonTitle = "Log In"
    private(set) var signUpPromptLabelText = "Have an account?"
    
    private weak var view: LogInViewInput?
    private let interactor: LogInInteractorInput
    private let router: LogInRouterInput
    
    private var loginState = LoginState.signIn
    
    init(
        view: LogInViewInput,
        interactor: LogInInteractorInput,
        router: LogInRouterInput
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - LogInViewOutput

extension LogInPresenter: LogInViewOutput {
    
    func viewDidLoad() {
        loginState == .signIn ? view?.applyLoginAppearance(withAnimation: false) : view?.applySignUpAppearance()
    }
    
    func didTapOnPromptButton() {
        updateLogInState()
    }
    
    func didTapOnLogInAppleButton() {
        
    }
    
    func didTapOnLogInGoogleButton() {
        
    }
    
    func didTapOnLogInButton(username: String?, email: String?, password: String?, confirmPassword: String?) {
        guard
            let username = username,
            let email = email,
            let password = password,
            let confirmPassword = confirmPassword
        else { return }
        
        view?.showLoader()
        switch loginState {
        case .signIn:
            interactor.logIn(data: .init(email: email, password: password)) { result in
                switch result {
                case .success:
                    self.router.pop()
                    self.interactor.updateFavorites()
                case .failure(let error):
                    self.view?.showError(error.description)
                }
                self.view?.hideLoader()
            }
            
        case .signUp:
            interactor.signUp(data:
                    .init(username: username, email: email, password: password, confirmPassword: confirmPassword)
            ) { result in
                switch result {
                case .success:
                    self.updateLogInState()
                case .failure(let error):
                    self.view?.showError(error.description)
                }
                self.view?.hideLoader()
            }
        }
    }
    
}

// MARK: - LogInInteractorOutput

extension LogInPresenter: LogInInteractorOutput {
    
}

private extension LogInPresenter {
    
    func updateLogInState() {
        view?.hideError()
        switch loginState {
        case .signIn:
            loginState = .signUp
            view?.applySignUpAppearance()
        case .signUp:
            loginState = .signIn
            view?.applyLoginAppearance(withAnimation: true)
        }
    }
    
}
