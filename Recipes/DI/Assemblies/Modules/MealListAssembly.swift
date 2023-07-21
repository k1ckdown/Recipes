//
//  MealListAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Swinject

final class MealListAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(MealListInteractor.self) { (resolver, listType: MealListType) in
            guard let mealRepository = resolver.resolve(MealRepositoryProtocol.self) else {
                fatalError("MealRepositoryProtocol dependency could not be resolved")
            }
            
            return MealListInteractor(mealRepository: mealRepository, listType: listType)
        }
        
        container.register(MealListRouter.self) { (_, view: MealListViewController) in
            return MealListRouter(view: view)
        }
        
        container.register(MealListPresenter.self) { (resolver, view: MealListViewController, listType: MealListType) in
            guard let interactor = resolver.resolve(MealListInteractor.self, argument: listType) else {
                fatalError("MealListInteractor dependency could not be resolved")
            }

            guard let router = resolver.resolve(MealListRouter.self, argument: view) else {
                fatalError("MealListRouter dependency could not be resolved")
            }
            
            let presenter = MealListPresenter(view: view, interactor: interactor, router: router)
            interactor.output = presenter
            return presenter
        }
        
        container.register(MealListViewController.self) { (resolver, listType: MealListType) in
            let view = MealListViewController()
            
            guard let presenter = resolver.resolve(MealListPresenter.self, arguments: view, listType) else {
                fatalError("MealListPresenter dependency could not be resolved")
            }
            
            view.output = presenter
            return view
        }
        
    }
    
}
