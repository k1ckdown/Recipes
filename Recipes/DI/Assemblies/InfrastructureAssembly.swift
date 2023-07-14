//
//  InfrastructureAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 08.07.2023.
//

import Swinject

final class InfrastructureAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(AuthService.self) { resolver in
            return AuthService()
        }
        .inObjectScope(.container)
        
        container.register(NetworkManager.self) { _ in
            return NetworkManager()
        }
        .inObjectScope(.container)
        
        container.register(MealLocalDataSource.self) { _ in
            return MealLocalDataSource()
        }
        .inObjectScope(.container)
        
        container.register(MealRepository.self) { resolver in
            guard let networkManager = resolver.resolve(NetworkManager.self) else {
                fatalError("NetworkManager dependency could not be resolved")
            }
            
            guard let mealLocalDataSource = resolver.resolve(MealLocalDataSource.self) else {
                fatalError("MealLocalDataSource dependency could not be resolved")
            }
            
            guard let authService = resolver.resolve(AuthService.self) else {
                fatalError("AuthService dependency could not be resolved")
            }
            
            return MealRepository(networkManager: networkManager,
                                  mealDataSource: mealLocalDataSource,
                                  authService: authService)
        }
        .inObjectScope(.container)

    }
    
}
