//
//  PersonalInfoPresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 22.07.2023.
//

import Foundation

final class PersonalInfoPresenter {
    
    private(set) var cellModels: [PersonalInfoCellModel] = [
        TextFieldCellModel(placeholder: "Username"),
        TextFieldCellModel(placeholder: "Email"),
        SegmentedControlCellModel(items: ["Male", "Female"]),
        TextFieldCellModel(placeholder: "Email")
    ]
 
    private weak var view: PersonalInfoViewInput?
    private let interactor: PersonalInfoInteractorInput
    private let router: PersonalInfoRouterInput
    
    private(set) var sections = PersonalInfoSection.allCases
    
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

// MARK: - PersonalInfoViewOutput

extension PersonalInfoPresenter: PersonalInfoViewOutput {
    
    func numberOfSections() -> Int {
        sections.count
    }
    
    func numberOfRowsInSection() -> Int {
        1
    }
    
    func headerTitle(at section: Int) -> String {
        return sections[section].headerTitle
    }
    
    func heightForRowAt(at indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].heightForRow
    }
    
    func heightForFooter(at section: Int) -> CGFloat {
        return sections[section].heightForFooter
    }
    
    func didUpdateDateOfBirth(date: Date) {
        print(date)
    }
    
    func didSelectSexSegment(segment: Int) {
        print(segment)
    }
    
}

// MARK: - PersonalInfoInteractorOutput

extension PersonalInfoPresenter: PersonalInfoInteractorOutput {
    
}
