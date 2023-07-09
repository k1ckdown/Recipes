//
//  MealListAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation
import Swinject

final class MealListAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(MealListInteractor.self) { (r, listType: MealListType) in
            guard let mealRepository = r.resolve(MealRepository.self) else {
                fatalError("MealRepository dependency could not be resolved")
            }
            
            return MealListInteractor(mealRepository: mealRepository, listType: listType)
        }
        
        container.register(MealListRouter.self) { (_, view: MealListViewController) in
            return MealListRouter(view: view)
        }
        
        container.register(MealListPresenter.self) { (r, view: MealListViewController, listType: MealListType) in
            guard let interactor = r.resolve(MealListInteractor.self, argument: listType) else {
                fatalError("MealListInteractor dependency could not be resolved")
            }

            guard let router = r.resolve(MealListRouter.self, argument: view) else {
                fatalError("MealListRouter dependency could not be resolved")
            }
            
            let presenter = MealListPresenter(view: view, interactor: interactor, router: router)
            interactor.output = presenter
            return presenter
        }
        
        container.register(MealListViewController.self) { (r, listType: MealListType) in
            let view = MealListViewController()
            
            guard let presenter = r.resolve(MealListPresenter.self, arguments: view, listType) else {
                fatalError("MealListPresenter dependency could not be resolved")
            }
            
            view.output = presenter
            return view
        }
        
    }
    
}
