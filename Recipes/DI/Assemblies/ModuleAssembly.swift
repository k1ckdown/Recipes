//
//  ModuleAssembly.swift
//  Recipes
//
//  Created by Ivan Semenov on 08.07.2023.
//

import Foundation
import Swinject

final class ModuleAssembly: Assembly {
    
    func assemble(container: Container) {
        let assemblies: [Assembly] = [
            HomeAssembly(),
            SearchAssembly(),
            MealListAssembly(),
            MealDetailAssembly()
        ]
        
        assemblies.forEach { $0.assemble(container: container) }
    }
    
}
