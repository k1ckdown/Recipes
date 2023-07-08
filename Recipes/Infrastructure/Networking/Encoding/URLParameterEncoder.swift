//
//  URLParameterEncoder.swift
//  Recipes
//
//  Created by Ivan Semenov on 05.07.2023.
//

import Foundation

struct URLParameterEncoder: ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                urlComponents.queryItems?.append(
                    URLQueryItem(
                        name: key,
                        value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                    )
                )
            }
            
            urlRequest.url = urlComponents.url
        }
    }
    
}
