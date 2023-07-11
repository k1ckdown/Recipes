//
//  FavoritesAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import Foundation
import Swinject

final class FavoritesAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(FavoritesInteractor.self) { r in
            guard let mealRepository = r.resolve(MealRepository.self) else {
                fatalError("MealRepository dependency could not be resolved")
            }
            
            return FavoritesInteractor(mealRepository: mealRepository)
        }
        
        container.register(FavoritesRouter.self) { (_, view: FavoritesViewController) in
            return FavoritesRouter(view: view)
        }
        
        container.register(FavoritesPresenter.self) { (r, view: FavoritesViewController) in
            guard let interactor = r.resolve(FavoritesInteractor.self) else {
                fatalError("FavoritesInteractor dependency could not be resolved")
            }

            guard let router = r.resolve(FavoritesRouter.self, argument: view) else {
                fatalError("FavoritesRouter dependency could not be resolved")
            }
            
            let presenter = FavoritesPresenter(view: view, interactor: interactor, router: router)
            interactor.output = presenter
            return presenter
        }
        
        container.register(FavoritesViewController.self) { r in
            let view = FavoritesViewController()
            
            guard let presenter = r.resolve(FavoritesPresenter.self, argument: view) else {
                fatalError("FavoritesPresenter dependency could not be resolved")
            }
            
            view.output = presenter
            return view
        }
        
    }
    
}