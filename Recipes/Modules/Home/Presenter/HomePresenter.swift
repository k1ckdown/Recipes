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
    private(set) var latestMealCellModels = [FoodCellModel]()
    private(set) var randomMealCellModels = [FoodCellModel]()
    private(set) var ingredientCellModels = [FoodCellModel]()
    
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
                .init(foodName: $0.name, foodType: .latestMeal)
            }
            view?.refreshCollection()
        }
    }
    
    private var randomMeals = [Meal]() {
        didSet {
            randomMealCellModels = randomMeals.map {
                .init(foodName: $0.name, foodType: .randomMeal)
            }
            view?.refreshCollection()
        }
    }
    
    private var ingredients = [Ingredient]() {
        didSet {
            ingredientCellModels = ingredients.map {
                .init(foodName: $0.name, foodType: .ingredient)
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

extension HomePresenter: HomeViewOutput {
    func viewDidLoad() {
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
            return areas.count
        case .latestMeals:
            return latestMeals.count
        case .ingredients:
            return ingredients.count
        case .randomMeals:
            return randomMeals.count
        }
    }
    
}

extension HomePresenter: HomeInteractorOutput {
    
}

private extension HomePresenter {
    
    func getMealItems() {
        fetchAreas()
        fetchLatestMeals()
        fetchRandomMeals()
        fetchIngredients()
    }
    
    func fetchAreas() {
        interactor.getAreaList { result in
            switch result {
            case .success(let areas):
                self.areas = areas
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    func fetchLatestMeals() {
        interactor.getMealList(.latestMeals) { result in
            switch result {
            case .success(let latestMeals):
                self.latestMeals = latestMeals
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    func fetchRandomMeals() {
        interactor.getMealList(.randomMeals) { result in
            switch result {
            case .success(let randomMeals):
                self.randomMeals = randomMeals
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    func fetchIngredients() {
        interactor.getIngredients { result in
            switch result {
            case .success(let ingredients):
                self.ingredients = ingredients
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
}
