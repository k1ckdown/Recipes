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
    private(set) var searchPlaceholder = "Search recipes"
    
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
        fetchRandomMeals()
    }
    
    func numberOfItems() -> Int {
        mealCellModels.count
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        router.showMealDetail(mealId: meals[indexPath.row].id)
    }
    
    func didPerformSearch(_ value: String?) {
        guard let value = value else { return }
        fetchMealListByName(value)
    }
    
}

// MARK: - SearchInteractorOutput

extension SearchPresenter: SearchInteractorOutput {
    
}

private extension SearchPresenter {
    
    func fetchRandomMeals() {
        interactor.getRandomMealList { result in
            switch result {
            case .success(let meals):
                self.meals = meals
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    func fetchMealListByName(_ name: String) {
        interactor.getMealListByName(name) { result in
            switch result {
            case .success(let meals):
                self.meals = meals
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
}
