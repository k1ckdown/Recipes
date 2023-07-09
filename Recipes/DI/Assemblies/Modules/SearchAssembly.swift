//
//  SearchAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation
import Swinject

final class SearchAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(SearchInteractor.self) { r in
            guard let mealRepository = r.resolve(MealRepository.self) else {
                fatalError("MealRepository dependency could not be resolved")
            }
            
            return SearchInteractor(mealRepository: mealRepository)
        }
        
        container.register(SearchRouter.self) { (_, view: SearchViewController) in
            return SearchRouter(view: view)
        }
        
        container.register(SearchPresenter.self) { (r, view: SearchViewController) in
            guard let interactor = r.resolve(SearchInteractor.self) else {
                fatalError("SearchInteractor dependency could not be resolved")
            }

            guard let router = r.resolve(SearchRouter.self, argument: view) else {
                fatalError("SearchRouter dependency could not be resolved")
            }
            
            let presenter = SearchPresenter(view: view, interactor: interactor, router: router)
            interactor.output = presenter
            return presenter
        }
        
        container.register(SearchViewController.self) { r in
            let view = SearchViewController()
            
            guard let presenter = r.resolve(SearchPresenter.self, argument: view) else {
                fatalError("SearchViewController dependency could not be resolved")
            }
            
            view.output = presenter
            return view
        }
        
    }
    
}
