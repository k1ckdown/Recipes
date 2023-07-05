//
//  MealDTO.swift
//  Recipes
//
//  Created by Ivan Semenov on 05.07.2023.
//

import Foundation

struct MealDTO: Decodable {
    let id: String
    let name: String
    let category: String?
    let area: String?
    let instructions: String?
    let thumbnailLink: String
    let youtubeLink: String?
    let tags: [String]?
    let ingredients: [MealIngredientDTO]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .idMeal)
        name = try container.decode(String.self, forKey: .strMeal)
        category = try container.decodeIfPresent(String.self, forKey: .strCategory)
        area = try container.decodeIfPresent(String.self, forKey: .strArea)
        instructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        thumbnailLink = try container.decode(String.self, forKey: .strMealThumb)
        youtubeLink = try container.decodeIfPresent(String.self, forKey: .strYoutube)
        tags = try container.decodeIfPresent(String.self, forKey: .strTags)?.components(separatedBy: ",")
        
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        let ingredientKeyValue = "strIngredient"
        let measureKeyValue = "strMeasure"
        var tempIngredients = [MealIngredientDTO]()
        
        for ingredientKey in dynamicContainer.allKeys.filter({ $0.stringValue.contains(ingredientKeyValue) }) {
            guard
                let ingredient = try? dynamicContainer.decodeIfPresent(String.self, forKey: ingredientKey),
                !ingredient.isEmpty
            else { continue }
            
            let startNumIndex = String.Index(utf16Offset: ingredientKeyValue.count, in: ingredientKey.stringValue)
            let num = ingredientKey.stringValue[startNumIndex...]
            
            guard
                let measureKey = DynamicCodingKeys(stringValue: measureKeyValue + num),
                let measure = try? dynamicContainer.decodeIfPresent(String.self, forKey: measureKey)
            else { continue }
            
            tempIngredients.append(.init(measure: measure, ingredient: ingredient))
        }

        ingredients = tempIngredients
    }
    
    private enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strCategory
        case strArea
        case strInstructions
        case strMealThumb
        case strYoutube
        case strTags
    }
    
    private struct DynamicCodingKeys: CodingKey {
         var stringValue: String
         
         init?(stringValue: String) {
             guard CodingKeys(rawValue: stringValue) == nil else {
                 return nil
             }
             
             self.stringValue = stringValue
         }
         
         var intValue: Int? { return nil }
         init?(intValue: Int) { return nil }
     }
}

struct MealIngredientDTO: Decodable {
    let measure: String
    let ingredient: String
}

struct MealListResponse: Decodable {
    let meals: [MealDTO]
}
