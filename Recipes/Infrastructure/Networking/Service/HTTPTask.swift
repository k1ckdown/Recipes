//
//  HTTPTask.swift
//  Recipes
//
//  Created by Ivan Semenov on 05.07.2023.
//

import Foundation

enum HTTPTask {
    case request
    case requestParameters(
        bodyEncoding: ParameterEncoding,
        bodyParameters: Parameters? = nil,
        urlParameters: Parameters?
    )
}

