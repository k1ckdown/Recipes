//
//  InfrastructureAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 08.07.2023.
//

import Swinject

final class InfrastructureAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(NetworkManager.self) { _ in
            return NetworkManager()
        }
        .inObjectScope(.container)
        
        container.register(MealLocalDataSource.self) { _ in
            return MealLocalDataSource()
        }
        .inObjectScope(.container)
        
        container.register(MealRepository.self) { r in
            guard let networkManager = r.resolve(NetworkManager.self) else {
                fatalError("NetworkManager dependency could not be resolved")
            }
            
            guard let mealLocalDataSource = r.resolve(MealLocalDataSource.self) else {
                fatalError("MealLocalDataSource dependency could not be resolved")
            }
            
            return MealRepository(networkManager: networkManager, mealDataSource: mealLocalDataSource)
        }
        .inObjectScope(.container)

    }
    
}
