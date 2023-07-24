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
    
    private var sex: Sex?
    private var dateOfBirth: Date?
    private var draftUser: User?
    private var user: User?
    
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
        fetchUser()
    }
    
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
        draftUser?.dateOfBirth = date
    }
    
    func didSelectSexSegment(segment: Int) {
        draftUser?.sex = Sex(rawValue: segment)
    }
    
    func didEndEditingName(_ value: String?) {
        guard let username = value else { return }
        draftUser?.username = username
    }
    
    func didEndEditingEmail(_ value: String?) {
        guard let email = value else { return }
        draftUser?.email = email
    }
    
    func didTapOnSaveChangesButton() {
        guard let draftUser = draftUser else { return }
        interactor.updateUserInfo(draftUser) { error in
            if let error = error {
                self.router.presentErrorAlert(with: error.description)
                self.draftUser = self.user
                self.updatePersonalInfo()
            } else {
                self.user = draftUser
            }
        }
    }
    
}

// MARK: - PersonalInfoInteractorOutput

extension PersonalInfoPresenter: PersonalInfoInteractorOutput {
    
}

private extension PersonalInfoPresenter {
    
    func updatePersonalInfo() {
        for model in cellModels {
            switch model {
            case let textFieldModel as TextFieldCellModel:
                textFieldModel.value = textFieldModel.type == .email ?  user?.email : user?.username
            case let segmentedControlModel as SegmentedControlCellModel:
                segmentedControlModel.selectedIndex = user?.sex?.rawValue
            case let datePickerModel as DatePickerCellModel:
                datePickerModel.date = user?.dateOfBirth
            default:
                return
            }
        }
        
        view?.refreshList()
    }
    
    func fetchUser() {
        interactor.getUser { result in
            switch result {
            case .success(let user):
                self.user = user
                self.draftUser = user
                self.updatePersonalInfo()
            case .failure(let error):
                self.router.presentErrorAlert(with: error.description)
            }
        }
    }
    
}
