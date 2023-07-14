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
