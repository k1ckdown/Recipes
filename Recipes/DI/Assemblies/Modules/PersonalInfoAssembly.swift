//
//  PersonalInfoAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 23.07.2023.
//

import Swinject

final class PersonalInfoAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(PersonalInfoInteractor.self) { resolver in
            guard let userRepository = resolver.resolve(UserRepository.self) else {
                fatalError("UserRepository dependency could not be resolved")
            }
            
            return PersonalInfoInteractor(userRepository: userRepository)
        }
        
        container.register(PersonalInfoRouter.self) { (_, view: PersonalInfoViewController) in
            return PersonalInfoRouter(view: view)
        }
        
        container.register(PersonalInfoPresenter.self) { (resolver, view: PersonalInfoViewController) in
            guard let interactor = resolver.resolve(PersonalInfoInteractor.self) else {
                fatalError("PersonalInfoInteractor dependency could not be resolved")
            }

            guard let router = resolver.resolve(PersonalInfoRouter.self, argument: view) else {
                fatalError("PersonalInfoRouter dependency could not be resolved")
            }
            
            let presenter = PersonalInfoPresenter(view: view, interactor: interactor, router: router)
            interactor.output = presenter
            return presenter
        }
        
        container.register(PersonalInfoViewController.self) { resolver in
            let view = PersonalInfoViewController()
            
            guard let presenter = resolver.resolve(PersonalInfoPresenter.self, argument: view) else {
                fatalError("PersonalInfoPresenter dependency could not be resolved")
            }
            
            view.output = presenter
            return view
        }
        
    }
    
}
