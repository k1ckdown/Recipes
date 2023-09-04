//
//  CreateRecipeAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.09.2023.
//

import Swinject

final class CreateRecipeAssembly: Assembly {

    func assemble(container: Container) {

        container.register(CreateRecipeInteractor.self) { resolver in
            CreateRecipeInteractor()
        }

        container.register(CreateRecipeRouter.self) { (_, view: CreateRecipeViewController) in
            CreateRecipeRouter(view: view)
        }

        container.register(CreateRecipePresenter.self) { (resolver, view: CreateRecipeViewController) in
            guard let interactor = resolver.resolve(CreateRecipeInteractor.self) else {
                fatalError("CreateRecipeInteractor dependency could not be resolved")
            }

            guard let router = resolver.resolve(CreateRecipeRouter.self, argument: view) else {
                fatalError("CreateRecipeRouter dependency could not be resolved")
            }

            let presenter = CreateRecipePresenter(view: view, interactor: interactor, router: router)
            interactor.output = presenter
            return presenter
        }

        container.register(CreateRecipeViewController.self) { resolver in
            let view = CreateRecipeViewController()

            guard let presenter = resolver.resolve(CreateRecipePresenter.self, argument: view) else {
                fatalError("CreateRecipePresenter dependency could not be resolved")
            }

            view.output = presenter
            return view
        }

    }

}
