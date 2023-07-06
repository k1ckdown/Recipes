//
//  MealRepository.swift
//  Recipes
//
//  Created by Ivan Semenov on 06.07.2023.
//

import Foundation

final class MealRepository {
    
    private let networkManager: NetworkManager
    
    init() {
        self.networkManager = NetworkManager()
    }
}
