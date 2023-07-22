//
//  PersonalInfoPresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 22.07.2023.
//

import Foundation

final class PersonalInfoPresenter {
 
    private weak var view: PersonalInfoViewInput?
    private let interactor: PersonalInfoInteractorInput
    private let router: PersonalInfoRouterInput
    
    init(
        view: PersonalInfoViewInput,
        interactor: PersonalInfoInteractorInput,
        router: PersonalInfoRouterInput
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
