//
//  CategoryDTO.swift
//  Recipes
//
//  Created by Ivan Semenov on 05.07.2023.
//

import Foundation

struct CategoryDTO: Decodable {
    let id: String
    let name: String
    let thumbnailLink: String
    let description: String
    
    func toCategory() -> Category {
        .init(id: id,
              name: name,
              description: description,
              thumbnailLink: thumbnailLink)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case thumbnailLink = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}

struct CategoryListResponse: Decodable {
    let categories: [CategoryDTO]
    
    struct CategoryListResponse: Decodable {
        let categories: [CategoryDTO]
        
        private enum CodingKeys: String, CodingKey {
            case categories = "meals"
        }
    }
}
