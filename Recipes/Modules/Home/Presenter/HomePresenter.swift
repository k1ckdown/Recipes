//
//  HomePresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import Foundation

final class HomePresenter {
    
    private(set) var areaCellModels = [AreaCellModel]()
    private(set) var categoryCellModels = [FoodCellModel]()
    private(set) var latestMealCellModels = [FoodCellModel]()
    private(set) var popularMealCellModels = [FoodCellModel]()
    
    private weak var view: HomeViewInput?
    private let router: HomeRouterInput
    private let interactor: HomeInteractorInput
    private let sections = HomeSection.allCases
    
    init(
        view: HomeViewInput,
        interactor: HomeInteractorInput,
        router: HomeRouterInput
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - HomeViewOutput

extension HomePresenter: HomeViewOutput {
    
    func section(at index: Int) -> HomeSection {
        sections[index]
    }
    
    func numberOfSections() -> Int {
        sections.count
    }
    
    func viewDidLoad() {
        view?.showLoader()
        getMealItems()
    }
    
    func numberOfItems(at sectionIndex: Int) -> Int {
        let section = sections[sectionIndex]
        
        switch section {
        case .areas:
            return areaCellModels.count
        case .latestMeals:
            return latestMealCellModels.count
        case .categories:
            return categoryCellModels.count
        case .popularMeals:
            return popularMealCellModels.count
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let index = indexPath.item
        let section = sections[indexPath.section]

        switch section {
        case .latestMeals:
            didSelectMeal(mealId: interactor.getLatestMealId(at: index))
        case .popularMeals:
            didSelectMeal(mealId: interactor.getPopularMealId(at: index))
        case .areas:
            router.showMealList(
                mealListType: .byArea(area: interactor.getAreaName(at: index))
            )
        case .categories:
            router.showMealList(
                mealListType: .byCategory(category: interactor.getCategoryName(at: index))
            )
        }
    }
    
}

// MARK: - HomeInteractorOutput

extension HomePresenter: HomeInteractorOutput {
    
    func onError(message: String) {
        router.presentErrorAlert(with: message)
    }
    
    func didRetrieveAreas(_ areas: [Area]) {
        areaCellModels = areas.map { .init(areaName: $0.name) }
        view?.refreshCollection()
    }
    
    func didRetrieveLatestMeals(_ meals: [Meal]) {
        latestMealCellModels = meals.map {
            .init(foodName: $0.name, imageUrl: $0.thumbnailLink, foodType: .latestMeal)
        }
        view?.refreshCollection()
    }
    
    func didRetrievePopularMeals(_ meals: [Meal]) {
        popularMealCellModels = meals.map {
            .init(foodName: $0.name, imageUrl: $0.thumbnailLink, foodType: .defaultMeal)
        }
        view?.refreshCollection()
        view?.hideLoader()
    }
    
    func didRetrieveCategories(_ categories: [Category]) {
        categoryCellModels = categories.map {
            .init(foodName: $0.name, imageUrl: $0.thumbnailLink, foodType: .category)
        }
        view?.refreshCollection()
    }
    
}

// MARK: - Private methods

private extension HomePresenter {
    
    func didSelectMeal(mealId: String) {
        router.showMealDetail(mealId: mealId)
    }
    
    func getMealItems() {
        interactor.retrieveLatestMealList()
        interactor.retrieveCategories()
        interactor.retrieveAreaList()
        interactor.retrievePopularMealList()
    }
    
}
