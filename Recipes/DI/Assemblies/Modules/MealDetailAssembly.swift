//
//  MealDetailAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 08.07.2023.
//

import Swinject

final class MealDetailAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(MealDetailInteractor.self) { (resolver, mealId: String) in
            guard let mealRepository = resolver.resolve(MealRepositoryProtocol.self) else {
                fatalError("MealRepositoryProtocol dependency could not be resolved")
            }
            
            return MealDetailInteractor(mealRepository: mealRepository, mealId: mealId)
        }
        
        container.register(MealDetailRouter.self) { (_, view: MealDetailViewController) in
            return MealDetailRouter(view: view)
        }
        
        container.register(MealDetailPresenter.self) { (resolver, view: MealDetailViewController, mealId: String) in
            guard let interactor = resolver.resolve(MealDetailInteractor.self, argument: mealId) else {
                fatalError("MealDetailInteractor dependency could not be resolved")
            }

            guard let router = resolver.resolve(MealDetailRouter.self, argument: view) else {
                fatalError("MealDetailRouter dependency could not be resolved")
            }
            
            let presenter = MealDetailPresenter(view: view, interactor: interactor, router: router)
            interactor.output = presenter
            return presenter
        }
        
        container.register(MealDetailViewController.self) { (resolver, mealId: String) in
            let view = MealDetailViewController()
            
            guard let presenter = resolver.resolve(MealDetailPresenter.self, arguments: view, mealId) else {
                fatalError("MealDetailPresenter dependency could not be resolved")
            }
            
            view.output = presenter
            return view
        }
        
    }
    
}
