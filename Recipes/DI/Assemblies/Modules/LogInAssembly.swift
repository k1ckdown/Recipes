//
//  LogInAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import Swinject

final class LogInAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(LogInInteractor.self) { resolver in
            guard let authService = resolver.resolve(AuthService.self) else {
                fatalError("AuthService dependency could not be resolved")
            }
            
            return LogInInteractor(authService: authService)
        }
        
        container.register(LogInRouter.self) { (_, view: LogInViewController) in
            return LogInRouter(view: view)
        }
        
        container.register(LogInPresenter.self) { (resolver, view: LogInViewController) in
            guard let interactor = resolver.resolve(LogInInteractor.self) else {
                fatalError("LogInInteractor dependency could not be resolved")
            }

            guard let router = resolver.resolve(LogInRouter.self, argument: view) else {
                fatalError("LogInRouter dependency could not be resolved")
            }
            
            let presenter = LogInPresenter(view: view, interactor: interactor, router: router)
            interactor.output = presenter
            return presenter
        }
        
        container.register(LogInViewController.self) { resolver in
            let view = LogInViewController()
            
            guard let presenter = resolver.resolve(LogInPresenter.self, argument: view) else {
                fatalError("LogInPresenter dependency could not be resolved")
            }
            
            view.output = presenter
            return view
        }
        
    }
    
}
