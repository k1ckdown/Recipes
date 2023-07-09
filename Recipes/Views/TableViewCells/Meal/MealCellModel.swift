//
//  MealCellModel.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

final class MealCellModel {
    
    private(set) var mealName: String
    private(set) var areaName: String
    private(set) var imageUrl: String
    private(set) var categoryName: String
    
    init(mealName: String, areaName: String, imageUrl: String, categoryName: String) {
        self.mealName = mealName
        self.areaName = areaName
        self.imageUrl = imageUrl
        self.categoryName = categoryName
    }
    
}
