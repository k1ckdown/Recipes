//
//  DIContainer.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import Foundation
import Swinject

final class DIContainer {
    
    static let shared = DIContainer()
    
    private let assembler: Assembler
    private let container: Container
    
    private init() {
        container = .init()
        assembler = Assembler(
            [
                InfrastructureAssembly(),
                ModuleAssembly()
            ],
            container: container)
    }
    
    func resolve<T>() -> T {
        guard let resolvedType = container.resolve(T.self) else {
            fatalError()
        }
        return resolvedType
    }
    
    func resolve<T, Arg>(argument: Arg) -> T {
        guard let resolvedType = container.resolve(T.self, argument: argument) else {
            fatalError()
        }
        return resolvedType
    }
    
}
