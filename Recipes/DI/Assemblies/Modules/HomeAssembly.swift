//
//  HomeAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Foundation
import Swinject

final class HomeAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(HomeInteractor.self) { r in
            guard let mealRepository = r.resolve(MealRepository.self) else {
                fatalError("MealRepository dependency could not be resolved")
            }
            
            return HomeInteractor(mealRepository: mealRepository)
        }
        
        container.register(HomeRouter.self) { (_, view: HomeViewController) in
            return HomeRouter(view: view)
        }
        
        container.register(HomePresenter.self) { (r, view: HomeViewController) in
            guard let interactor = r.resolve(HomeInteractor.self) else {
                fatalError("HomeInteractor dependency could not be resolved")
            }

            guard let router = r.resolve(HomeRouter.self, argument: view) else {
                fatalError("HomeRouter dependency could not be resolved")
            }
            
            let presenter = HomePresenter(view: view, interactor: interactor, router: router)
            interactor.output = presenter
            return presenter
        }
        
        container.register(HomeViewController.self) { r in
            let view = HomeViewController()
            
            guard let presenter = r.resolve(HomePresenter.self, argument: view) else {
                fatalError("HomePresenter dependency could not be resolved")
            }
            
            view.output = presenter
            return view
        }
        
    }
    
}
