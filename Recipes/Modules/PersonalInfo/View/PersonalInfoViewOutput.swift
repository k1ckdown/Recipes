//
//  PersonalInfoViewOutput.swift
//  Recipes
//
//  Created by Ivan Semenov on 22.07.2023.
//

import Foundation

protocol PersonalInfoViewOutput: AnyObject {
    var sections: [PersonalInfoSection] { get }
    var cellModels: [PersonalInfoCellModel] { get }
    
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
    func didUpdateDateOfBirth(date: Date)
    func didSelectSexSegment(segment: Int)
    func headerTitle(at section: Int) -> String
    func heightForFooter(at section: Int) -> CGFloat
    func heightForRowAt(at indexPath: IndexPath) -> CGFloat
}
