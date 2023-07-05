//
//  IngredientDTO.swift
//  Recipes
//
//  Created by Ivan Semenov on 06.07.2023.
//

import Foundation

struct IngredientDTO: Decodable {
    let id: String
    let name: String
    let type: String?
    let description: String?
    
    private enum CodingKeys: String, CodingKey {
        case type = "strType"
        case id = "idIngredient"
        case name = "strIngredient"
        case description = "strDescription"
    }
}

struct IngredientListResponse: Decodable {
    let ingredients: [IngredientDTO]
    
    private enum CodingKeys: String, CodingKey {
        case ingredients = "meals"
    }
}
