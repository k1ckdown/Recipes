//
//  DatePickerCellModel.swift
//  Recipes
//
//  Created by Ivan Semenov on 24.07.2023.
//

import Foundation

final class DatePickerCellModel: PersonalInfoCellModel {
    
    var date: Date?
    
    init(date: Date? = nil) {
        self.date = date
    }
    
}

