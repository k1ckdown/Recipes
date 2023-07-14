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
    
}

// MARK: - LogInInteractorOutput

extension LogInPresenter: LogInInteractorOutput {
    
}
