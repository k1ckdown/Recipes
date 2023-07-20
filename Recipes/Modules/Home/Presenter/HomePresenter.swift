//
//  HomePresenter.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import Foundation

final class HomePresenter {
    
    private weak var view: HomeViewInput?
    private let interactor: HomeInteractorInput
    private let router: HomeRouterInput
    
    private(set) var areaCellModels = [AreaCellModel]()
    private(set) var categoryCellModels = [FoodCellModel]()
    private(set) var latestMealCellModels = [FoodCellModel]()
    private(set) var popularMealCellModels = [FoodCellModel]()
    
    private let sections = HomeSection.allCases
    
    private var areas = [Area]() {
        didSet {
            areaCellModels = areas.map { .init(areaName: $0.name) }
            view?.refreshCollection()
        }
    }
    
    private var latestMeals = [Meal]() {
        didSet {
            latestMealCellModels = latestMeals.map {
                .init(foodName: $0.name, imageUrl: $0.thumbnailLink, foodType: .latestMeal)
            }
            view?.refreshCollection()
        }
    }
    
    private var popularMeals = [Meal]() {
        didSet {
            popularMealCellModels = popularMeals.map {
                .init(foodName: $0.name, imageUrl: $0.thumbnailLink, foodType: .defaultMeal)
            }
            view?.refreshCollection()
        }
    }
    
    private var categories = [Category]() {
        didSet {
            categoryCellModels = categories.map {
                .init(foodName: $0.name, imageUrl: $0.thumbnailLink, foodType: .category)
            }
            view?.refreshCollection()
        }
    }
    
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
    func viewDidLoad() {
        view?.showLoader()
        getMealItems()
    }
    
    func section(at index: Int) -> HomeSection {
        return sections[index]
    }
    
    func numberOfSections() -> Int {
        return sections.count
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
    
}

// MARK: - HomeInteractorOutput

extension HomePresenter: HomeInteractorOutput {
    func didSelectItem(at indexPath: IndexPath) {
        let section = sections[indexPath.section]
        
        switch section {
        case .latestMeals:
            selectMeal(meal: latestMeals[indexPath.item])
        case .categories:
            router.showMealList(
                mealListType: .byCategory(category: categories[indexPath.item].name)
            )
        case .areas:
            router.showMealList(
                mealListType: .byArea(area: areas[indexPath.item].name)
            )
        case .popularMeals:
            selectMeal(meal: popularMeals[indexPath.item])
        }
    }
}

private extension HomePresenter {
    
    func selectMeal(meal: Meal) {
        router.showMealDetail(mealId: meal.id)
    }
    
    func getMealItems() {
        fetchLatestMeals()
        fetchCategories()
        fetchAreas()
        fetchPopularMeals()
    }
    
    func fetchAreas() {
        interactor.getAreaList { result in
            switch result {
            case .success(let areas):
                self.areas = areas
            case .failure(let error):
                self.router.presentErrorAlert(with: error.description)
            }
        }
    }
    
    func fetchCategories() {
        interactor.getCategories { result in
            switch result {
            case .success(let categories):
                self.categories = categories
            case .failure(let error):
                self.router.presentErrorAlert(with: error.description)
            }
        }
    }
    
    func fetchLatestMeals() {
        interactor.getLatestMealList { result in
            switch result {
            case .success(let latestMeals):
                self.latestMeals = latestMeals
            case .failure(let error):
                self.router.presentErrorAlert(with: error.description)
            }
        }
    }
    
    func fetchPopularMeals() {
        interactor.getPopularMealList { result in
            switch result {
            case .success(let popularMeals):
                self.popularMeals = popularMeals
            case .failure(let error):
                self.router.presentErrorAlert(with: error.description)
            }
            self.view?.hideLoader()
        }
    }
    
}
