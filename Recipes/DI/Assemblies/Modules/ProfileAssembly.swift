//
//  ProfileAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import Swinject

final class ProfileAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(ProfileInteractor.self) { resolver in
            guard let mealRepository = resolver.resolve(MealRepository.self) else {
                fatalError("MealRepository dependency could not be resolved")
            }
            
            guard let authService = resolver.resolve(AuthService.self) else {
                fatalError("AuthService dependency could not be resolved")
            }
            
            return ProfileInteractor(authService: authService, mealRepository: mealRepository)
        }
        
        container.register(ProfileRouter.self) { (_, view: ProfileViewController) in
            return ProfileRouter(view: view)
        }
        
        container.register(ProfilePresenter.self) { (resolver, view: ProfileViewController) in
            guard let interactor = resolver.resolve(ProfileInteractor.self) else {
                fatalError("ProfileInteractor dependency could not be resolved")
            }

            guard let router = resolver.resolve(ProfileRouter.self, argument: view) else {
                fatalError("ProfileRouter dependency could not be resolved")
            }
            
            let presenter = ProfilePresenter(view: view, interactor: interactor, router: router)
            interactor.output = presenter
            return presenter
        }
        
        container.register(ProfileViewController.self) { resolver in
            let view = ProfileViewController()
            
            guard let presenter = resolver.resolve(ProfilePresenter.self, argument: view) else {
                fatalError("ProfilePresenter dependency could not be resolved")
            }
            
            view.output = presenter
            return view
        }
        
    }
    
}
