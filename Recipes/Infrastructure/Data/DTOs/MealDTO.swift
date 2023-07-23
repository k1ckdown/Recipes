//
//  MealDTO.swift
//  Recipes
//
//  Created by Ivan Semenov on 05.07.2023.
//

import Foundation
import FirebaseFirestore

struct MealDTO: Codable {
    let id: String
    let name: String
    let category: String?
    let area: String?
    let instructions: String?
    let thumbnailLink: String
    let youtubeLink: String?
    let tags: [String]?
    let ingredients: [MealIngredientDTO]
    var documentRef: DocumentReference?
    
    init(
        id: String,
        name: String,
        category: String?,
        area: String?,
        instructions: String?,
        thumbnailLink: String,
        youtubeLink: String?,
        tags: [String]?,
        ingredients: [MealIngredientDTO]
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.area = area
        self.instructions = instructions
        self.thumbnailLink = thumbnailLink
        self.youtubeLink = youtubeLink
        self.tags = tags
        self.ingredients = ingredients
    }
    
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
                
        if let ingredientsKey = DynamicCodingKeys(stringValue: "ingredients") {
            guard !dynamicContainer.contains(ingredientsKey) else {
                ingredients = try dynamicContainer.decode([MealIngredientDTO].self, forKey: ingredientsKey)
                return
            }
        }

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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .idMeal)
        try container.encode(name, forKey: .strMeal)
        try container.encodeIfPresent(category, forKey: .strCategory)
        try container.encodeIfPresent(area, forKey: .strArea)
        try container.encodeIfPresent(instructions, forKey: .strInstructions)
        try container.encode(thumbnailLink, forKey: .strMealThumb)
        try container.encodeIfPresent(youtubeLink, forKey: .strYoutube)
        try container.encodeIfPresent(tags?.joined(separator: ","), forKey: .strTags)
        
        guard let ingredientsKey = DynamicCodingKeys(stringValue: "ingredients") else { return }
        var dynamicContainer = encoder.container(keyedBy: DynamicCodingKeys.self)
        try dynamicContainer.encode(ingredients, forKey: ingredientsKey)
    }
    
    func toMeal() -> Meal {
        .init(id: id,
              name: name,
              category: category,
              area: area,
              instructions: instructions,
              thumbnailLink: thumbnailLink,
              youtubeLink: youtubeLink,
              tags: tags,
              ingredients: ingredients.map { $0.toMealIngredient() })
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

struct MealIngredientDTO: Codable {
    let measure: String
    let ingredient: String
    
    func toMealIngredient() -> MealIngredient {
        let percentEncodedName = ingredient.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let thumbnailLink = "\(NetworkManager.ingredientImageUrl)\(percentEncodedName ?? "").png"
        
        return .init(measure: measure,
                     ingredient: ingredient,
                     thumbnailLink: thumbnailLink)
    }
}

struct MealListResponse: Codable {
    let meals: [MealDTO]
}
