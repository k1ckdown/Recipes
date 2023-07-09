//
//  IngredientCellModel.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Foundation

final class IngredientCellModel {
    
    private(set) var imageUrl: String
    private(set) var nameIngredient: String
    private(set) var measure: String
    
    init(imageUrl: String, nameIngredient: String, measure: String) {
        self.imageUrl = imageUrl
        self.nameIngredient = nameIngredient
        self.measure = measure
    }
    
}
