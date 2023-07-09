//
//  SearchPresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

final class SearchPresenter {
    
    private weak var view: SearchViewInput?
    private let interactor: SearchInteractorInput
    private let router: SearchRouterInput
    
    private(set) var mealCellModels = [MealCellModel]()
    
    private var meals = [Meal]() {
        didSet {
            mealCellModels = meals.map {
                .init(mealName: $0.name,
                      areaName: $0.area ?? "N/A",
                      imageUrl: $0.thumbnailLink,
                      categoryName: $0.category ?? "N/A")
            }
            view?.refreshList()
        }
    }
    
    init(
        view: SearchViewInput,
        interactor: SearchInteractorInput,
        router: SearchRouterInput
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - SearchViewOutput

extension SearchPresenter: SearchViewOutput {
    func viewDidLoad() {
        fetchMeals()
    }
    
    func numberOfItems() -> Int {
        mealCellModels.count
    }
}

// MARK: - SearchInteractorOutput

extension SearchPresenter: SearchInteractorOutput {
    
}

private extension SearchPresenter {
    
    func fetchMeals() {
        
    }
    
}
