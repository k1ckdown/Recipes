//
//  MealEndPoint.swift
//  Recipes
//
//  Created by Ivan Semenov on 05.07.2023.
//

import Foundation

enum MealAPI {
    case areaList
    case categories
    case latestMeals
    case popularMeals
    case ingredientList
    case mealById(id: Int)
    case mealByName(name: String)
    case mealsByArea(area: String)
    case mealsByCategory(category: String)
    case mealsByMainIngredient(ingredient: String)
}

extension MealAPI: EndPointType {
    
    var baseURL: URL {
        guard
            let url = URL(string: "https://themealdb.com/api/json/v2/\(NetworkManager.mealApiKey)")
        else {
            fatalError("Failed to configure the base url")
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .mealByName:
            return "search.php"
        case .mealById:
            return "lookup.php"
        case .latestMeals:
            return "latest.php"
        case .categories:
            return "categories.php"
        case .popularMeals:
            return "popular.php"
        case .areaList, .ingredientList:
            return "list.php"
        case .mealsByArea, .mealsByCategory, .mealsByMainIngredient:
            return "filter.php"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .categories:
            return .request
        case .latestMeals:
            return .request
        case .popularMeals:
            return .request
        case .areaList:
            return .requestParameters(bodyEncoding: .urlEncoding,
                                      urlParameters: ["a": "list"])
        case .ingredientList:
            return .requestParameters(bodyEncoding: .urlEncoding,
                                      urlParameters: ["i": "list"])
        case .mealById(let id):
            return .requestParameters(bodyEncoding: .urlEncoding,
                                      urlParameters: ["i": id])
        case .mealByName(let name):
            return .requestParameters(bodyEncoding: .urlEncoding,
                                      urlParameters: ["s": name])
        case .mealsByArea(let area):
            return .requestParameters(bodyEncoding: .urlEncoding,
                                      urlParameters: ["a": area])
        case .mealsByCategory(let category):
            return .requestParameters(bodyEncoding: .urlEncoding,
                                      urlParameters: ["c": category])
        case .mealsByMainIngredient(let ingredient):
            return .requestParameters(bodyEncoding: .urlEncoding,
                                      urlParameters: ["i": ingredient])
        }
    }
    
}
