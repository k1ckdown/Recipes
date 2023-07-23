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
    func headerTitle(at section: Int) -> String
    func heightForRowAt(at indexPath: IndexPath) -> CGFloat
}
