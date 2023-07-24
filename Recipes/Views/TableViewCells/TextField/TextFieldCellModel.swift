//
//  TextFieldCellModel.swift
//  Recipes
//
//  Created by Ivan Semenov on 23.07.2023.
//

import Foundation

final class TextFieldCellModel: PersonalInfoCellModel {
    
    var value: String?
    
    var tag: Int {
        type.rawValue
    }
    
    var placeholder: String {
        type.placeholder
    }
    
    private(set) var type: TextFieldType
    
    init(type: TextFieldType, value: String? = nil) {
        self.type = type
        self.value = value
    }
}
