//
//  FoodCellModel.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import Foundation

final class FoodCellModel {
    
    private(set) var foodName: String
    private(set) var imageUrl: String
    private(set) var foodType: FoodCellStyle
    
    init(foodName: String, imageUrl: String, foodType: FoodCellStyle) {
        self.foodName = foodName
        self.imageUrl = imageUrl
        self.foodType = foodType
    }
}
