//
//  LogInPresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import Foundation

final class LogInPresenter {
    
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
        loginState == .signIn ? view?.applyLoginAppearance() : view?.applySignUpAppearance()
    }
    
    func didTapOnPromptButton() {
        updateLogInState()
    }
    
    func didTapOnLogInButton(username: String?, email: String?, password: String?) {
        guard
            let username = username,
            let email = email,
            let password = password
        else { return }
        
        switch loginState {
        case .signIn:
            interactor.logIn(data: .init(email: email, password: password)) { result in
                switch result {
                case .success:
                    self.router.pop()
                case .failure(let error):
                    print(error.description)
                }
            }
            
        case .signUp:
            interactor.signUp(data: .init(username: username, email: email, password: password)) { result in
                switch result {
                case .success:
                    self.view?.applyLoginAppearance()
                case .failure(let error):
                    print(error.description)
                }
            }
        }
    }
    
}

// MARK: - LogInInteractorOutput

extension LogInPresenter: LogInInteractorOutput {
    
}

private extension LogInPresenter {
    
    func updateLogInState() {
        switch loginState {
        case .signIn:
            loginState = .signUp
            view?.applySignUpAppearance()
        case .signUp:
            loginState = .signIn
            view?.applyLoginAppearance()
        }
    }
    
}
