//
//  EndPointType.swift
//  Recipes
//
//  Created by Ivan Semenov on 05.07.2023.
//

import Foundation

protocol EndPointType {
    var baseUrl: URL { get }
    var path: String { get }
    var task: HTTPTask { get }
    var httpMethod: HTTPMethod { get }
}
