//
//  PersonalInfoPresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 22.07.2023.
//

import Foundation

final class PersonalInfoPresenter {
    
    private(set) var sceneTitle = "Personal Info"
    private(set) var saveChangesButtonTitle = "Save Changes"
    private(set) var sections = PersonalInfoSection.allCases
    private(set) var cellModels: [PersonalInfoCellModel] = [
        TextFieldCellModel(type: .username),
        TextFieldCellModel(type: .email),
        SegmentedControlCellModel(items: Sex.allCases.map { $0.name }),
        DatePickerCellModel()
    ]
 
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

// MARK: - PersonalInfoViewOutput

extension PersonalInfoPresenter: PersonalInfoViewOutput {
    
    func viewDidLoad() {
        interactor.retrieveUser()
    }
    
    func numberOfSections() -> Int {
        sections.count
    }
    
    func numberOfRowsInSection() -> Int {
        1
    }
    
    func headerTitle(at section: Int) -> String {
        sections[section].headerTitle
    }
    
    func heightForRowAt(at indexPath: IndexPath) -> CGFloat {
        sections[indexPath.section].heightForRow
    }
    
    func heightForFooter(at section: Int) -> CGFloat {
        sections[section].heightForFooter
    }
    
    func didTapOnSaveChangesButton() {
        interactor.saveUserChanges()
    }
    
    func didUpdateDateOfBirth(date: Date) {
        interactor.updateDateOfBirth(date)
    }
    
    func didSelectSexSegment(segment: Int) {
        interactor.updateSex(Sex(rawValue: segment))
    }
    
    func didEndEditingName(_ value: String?) {
        guard let username = value else { return }
        interactor.updateUsername(username)
    }
    
    func didEndEditingEmail(_ value: String?) {
        guard let email = value else { return }
        interactor.updateEmail(email)
    }
    
}

// MARK: - PersonalInfoInteractorOutput

extension PersonalInfoPresenter: PersonalInfoInteractorOutput {
    
    func onError(message: String) {
        router.presentErrorAlert(with: message)
    }
    
    func didRetrieveUser(_ user: User) {
        updatePersonalInfo(user: user)
    }
    
}

// MARK: - Private methods

private extension PersonalInfoPresenter {
    
    func updatePersonalInfo(user: User) {
        for model in cellModels {
            switch model {
            case let textFieldModel as TextFieldCellModel:
                textFieldModel.value = textFieldModel.type == .email ?  user.email : user.username
            case let segmentedControlModel as SegmentedControlCellModel:
                segmentedControlModel.selectedIndex = user.sex?.rawValue
            case let datePickerModel as DatePickerCellModel:
                datePickerModel.date = user.dateOfBirth
            default:
                return
            }
        }
        view?.refreshList()
    }
    
}
