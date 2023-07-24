//
//  InfrastructureAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 08.07.2023.
//

import Swinject

final class InfrastructureAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(UserRemoteDataSourceProtocol.self) { _ in
            return UserRemoteDataSource()
        }
        .inObjectScope(.container)
        
        container.register(UserRepositoryProtocol.self) { resolver in
            guard let userRemoteDataSource = resolver.resolve(UserRemoteDataSourceProtocol.self) else {
                fatalError("UserRemoteDataSourceProtocol dependency could not be resolved")
            }
            
            return UserRepository(remoteDataSource: userRemoteDataSource)
        }
        .inObjectScope(.container)
        
        container.register(AuthServiceProtocol.self) { resolver in
            guard let userRepository = resolver.resolve(UserRepositoryProtocol.self) else {
                fatalError("UserRepositoryProtocol dependency could not be resolved")
            }
            
            return  AuthService(userRepository: userRepository)
        }
        .inObjectScope(.container)
        
        container.register(NetworkManager.self) { _ in
            return NetworkManager()
        }
        .inObjectScope(.container)
        
        container.register(MealLocalDataSourceProtocol.self) { _ in
            return MealLocalDataSource()
        }
        .inObjectScope(.container)
        
        container.register(MealRemoteDataSourceProtocol.self) { resolver in
            return MealRemoteDataSource()
        }
        .inObjectScope(.container)
        
        container.register(MealRepositoryProtocol.self) { resolver in
            guard let networkManager = resolver.resolve(NetworkManager.self) else {
                fatalError("NetworkManager dependency could not be resolved")
            }
            
            guard let mealLocalDataSource = resolver.resolve(MealLocalDataSourceProtocol.self) else {
                fatalError("MealLocalDataSourceProtocol dependency could not be resolved")
            }
            
            guard let mealRemoteDataSource = resolver.resolve(MealRemoteDataSourceProtocol.self) else {
                fatalError("MealRemoteDataSourceProtocol dependency could not be resolved")
            }
            
            guard let authService = resolver.resolve(AuthServiceProtocol.self) else {
                fatalError("AuthServiceProtocol dependency could not be resolved")
            }
            
            return MealRepository(networkManager: networkManager,
                                  localDataSource: mealLocalDataSource,
                                  remoteDataSource: mealRemoteDataSource,
                                  authService: authService)
        }
        .inObjectScope(.container)

    }
    
}
