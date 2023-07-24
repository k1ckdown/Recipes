//
//  PersonalInfoViewOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 22.07.2023.
//

import Foundation

protocol PersonalInfoViewOutput: AnyObject {
    var sceneTitle: String { get }
    var sections: [PersonalInfoSection] { get }
    var cellModels: [PersonalInfoCellModel] { get }
    var saveChangesButtonTitle: String { get }
    
    func viewDidLoad()
    
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
    
    func didTapOnSaveChangesButton()
    func didUpdateDateOfBirth(date: Date)
    func didSelectSexSegment(segment: Int)
    func didEndEditingName(_ value: String?)
    func didEndEditingEmail(_ value: String?)
    
    func headerTitle(at section: Int) -> String
    func heightForFooter(at section: Int) -> CGFloat
    func heightForRowAt(at indexPath: IndexPath) -> CGFloat
}
