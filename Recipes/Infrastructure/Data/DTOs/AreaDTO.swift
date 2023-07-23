//
//  AreaDTO.swift
//  Recipes
//
//  Created by Ivan Semenov on 06.07.2023.
//

import Foundation

struct AreaDTO: Decodable {
    let name: String
    
    func toArea() -> Area {
        .init(name: name)
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "strArea"
    }
}

struct AreaListResponse: Decodable {
    let areas: [AreaDTO]
    
    private enum CodingKeys: String, CodingKey {
        case areas = "meals"
    }
}
