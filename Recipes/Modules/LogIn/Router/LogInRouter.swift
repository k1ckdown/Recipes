//
//  LogInRouter.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import Foundation

final class LogInRouter {
    
    private weak var view: LogInViewController?
    
    init(view: LogInViewController) {
        self.view = view
    }
    
}

// MARK: - LogInRouterInput

extension LogInRouter: LogInRouterInput {
    
}
