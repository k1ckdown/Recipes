//
//  MealDetailAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 08.07.2023.
//

import Foundation
import Swinject

final class MealDetailAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(MealDetailInteractor.self) { (r, mealId: String) in
            guard let mealRepository = r.resolve(MealRepository.self) else {
                fatalError("MealRepository dependency could not be resolved")
            }
            
            return MealDetailInteractor(mealRepository: mealRepository, mealId: mealId)
        }
        
        container.register(MealDetailRouter.self) { (_, view: MealDetailViewController) in
            return MealDetailRouter(view: view)
        }
        
        container.register(MealDetailPresenter.self) { (r, view: MealDetailViewController, mealId: String) in
            guard let interactor = r.resolve(MealDetailInteractor.self, argument: mealId) else {
                fatalError("MealDetailInteractor dependency could not be resolved")
            }

            guard let router = r.resolve(MealDetailRouter.self, argument: view) else {
                fatalError("MealDetailRouter dependency could not be resolved")
            }
            
            let presenter = MealDetailPresenter(view: view, interactor: interactor, router: router)
            interactor.output = presenter
            return presenter
        }
        
        container.register(MealDetailViewController.self) { (r, mealId: String) in
            let view = MealDetailViewController()
            
            guard let presenter = r.resolve(MealDetailPresenter.self, arguments: view, mealId) else {
                fatalError("MealDetailPresenter dependency could not be resolved")
            }
            
            view.output = presenter
            return view
        }
        
    }
    
}
