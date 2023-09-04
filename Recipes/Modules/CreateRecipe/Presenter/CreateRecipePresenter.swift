//
//  CreateRecipePresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.09.2023.
//

import Foundation

final class CreateRecipePresenter {

    private weak var view: CreateRecipeViewInput?
    private let interactor: CreateRecipeInteractorInput
    private let router: CreateRecipeRouterInput

    init(
        view: CreateRecipeViewInput,
        interactor: CreateRecipeInteractorInput,
        router: CreateRecipeRouterInput
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

}

// MARK: - CreateRecipeViewOutput

extension CreateRecipePresenter: CreateRecipeViewOutput {

}

// MARK: - CreateRecipeInteractorOutput

extension CreateRecipePresenter: CreateRecipeInteractorOutput {

}

// MARK: - Private methods

private extension CreateRecipePresenter {

}
