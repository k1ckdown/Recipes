//
//  SearchListType.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

enum SearchListType {
    case random
    case byArea(area: String)
    case byCategory(category: String)
}
