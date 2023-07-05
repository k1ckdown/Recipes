//
//  NetworkManager.swift
//  Recipes
//
//  Created by Ivan Semenov on 05.07.2023.
//

import Foundation

struct NetworkManager {
    static let mealApiKey = "9973533"
    let router = NetworkRouter<MealAPI>()
    
    func getMealData<T: Decodable>(mealEndPoint: MealAPI, completion: @escaping (Result<T, NetworkError>) -> Void) {
        router.request(mealEndPoint) { data, response, error in
            if let error = error {
                completion(.failure(.urlSessionError(error.localizedDescription)))
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                (200...300).contains(httpResponse.statusCode)
            else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let genericModel = try decoder.decode(T.self, from: data)
                completion(.success(genericModel))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.requestFailed))
            }
        }
    }
}
