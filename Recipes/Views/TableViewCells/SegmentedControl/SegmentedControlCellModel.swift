//
//  SegmentedControlCellModel.swift
//  Recipes
//
//  Created by Ivan Semenov on 23.07.2023.
//

import Foundation

final class SegmentedControlCellModel: PersonalInfoCellModel {
    
    private(set) var items: [Any]?
    
    init(items: [Any]?) {
        self.items = items
    }
}
