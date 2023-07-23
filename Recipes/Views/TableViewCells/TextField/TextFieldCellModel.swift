//
//  TextFieldCellModel.swift
//  Recipes
//
//  Created by Ivan Semenov on 23.07.2023.
//

import Foundation

final class TextFieldCellModel: PersonalInfoCellModel {
    
    private(set) var placeholder: String
    
    init(placeholder: String) {
        self.placeholder = placeholder
    }
}
