//
//  NetworkManager.swift
//  Recipes
//
//  Created by Ivan Semenov on 05.07.2023.
//

import Foundation

final class NetworkManager {
    static let mealApiKey = "9973533"
    static let ingredientImageUrl = "https://www.themealdb.com/images/ingredients/"
    
    private let mealRouter = NetworkRouter<MealAPI>()
    
    func fetchMealData<T: Decodable>(mealEndPoint: MealAPI, completion: @escaping (Result<T, NetworkError>) -> Void) {
        mealRouter.request(mealEndPoint) { data, response, error in
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
