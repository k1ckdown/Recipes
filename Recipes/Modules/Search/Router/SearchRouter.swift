//
//  SearchRouter.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

final class SearchRouter {
    
    private weak var view: SearchViewController?
    
    init(view: SearchViewController? = nil) {
        self.view = view
    }
    
}

extension SearchRouter: SearchRouterInput {
    
}


