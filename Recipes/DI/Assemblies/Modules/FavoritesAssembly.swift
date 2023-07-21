//
//  FavoritesAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import Swinject

final class FavoritesAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(FavoritesInteractor.self) { resolver in
            guard let mealRepository = resolver.resolve(MealRepositoryProtocol.self) else {
                fatalError("MealRepositoryProtocol dependency could not be resolved")
            }
            
            guard let authService = resolver.resolve(AuthServiceProtocol.self) else {
                fatalError("AuthServiceProtocol dependency could not be resolved")
            }
            
            return FavoritesInteractor(mealRepository: mealRepository, authService: authService)
        }
        
        container.register(FavoritesRouter.self) { (_, view: FavoritesViewController) in
            return FavoritesRouter(view: view)
        }
        
        container.register(FavoritesPresenter.self) { (resolver, view: FavoritesViewController) in
            guard let interactor = resolver.resolve(FavoritesInteractor.self) else {
                fatalError("FavoritesInteractor dependency could not be resolved")
            }

            guard let router = resolver.resolve(FavoritesRouter.self, argument: view) else {
                fatalError("FavoritesRouter dependency could not be resolved")
            }
            
            let presenter = FavoritesPresenter(view: view, interactor: interactor, router: router)
            interactor.output = presenter
            return presenter
        }
        
        container.register(FavoritesViewController.self) { resolver in
            let view = FavoritesViewController()
            
            guard let presenter = resolver.resolve(FavoritesPresenter.self, argument: view) else {
                fatalError("FavoritesPresenter dependency could not be resolved")
            }
            
            view.output = presenter
            return view
        }
        
    }
    
}
