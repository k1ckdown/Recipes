//
//  HomeAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Swinject

final class HomeAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(HomeInteractor.self) { resolver in
            guard let mealRepository = resolver.resolve(MealRepository.self) else {
                fatalError("MealRepository dependency could not be resolved")
            }
            
            return HomeInteractor(mealRepository: mealRepository)
        }
        
        container.register(HomeRouter.self) { (_, view: HomeViewController) in
            return HomeRouter(view: view)
        }
        
        container.register(HomePresenter.self) { (resolver, view: HomeViewController) in
            guard let interactor = resolver.resolve(HomeInteractor.self) else {
                fatalError("HomeInteractor dependency could not be resolved")
            }

            guard let router = resolver.resolve(HomeRouter.self, argument: view) else {
                fatalError("HomeRouter dependency could not be resolved")
            }
            
            let presenter = HomePresenter(view: view, interactor: interactor, router: router)
            interactor.output = presenter
            return presenter
        }
        
        container.register(HomeViewController.self) { resolver in
            let view = HomeViewController()
            
            guard let presenter = resolver.resolve(HomePresenter.self, argument: view) else {
                fatalError("HomePresenter dependency could not be resolved")
            }
            
            view.output = presenter
            return view
        }
        
    }
    
}
