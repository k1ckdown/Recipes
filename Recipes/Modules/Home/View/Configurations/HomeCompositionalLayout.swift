//
//  HomeCompositionalLayout.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit

enum HomeCompositionalLayout {
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {
            (sectionIndex, _) -> NSCollectionLayoutSection? in
            let section = HomeSection(rawValue: sectionIndex)
            
            switch section {
            case .areas:
                return makeCountriesSection()
            case .latestMeals:
                return makeLatestMealsSection()
            case .ingredients:
                return makeIngredientsSection()
            case .randomMeals:
                return makeRandomMealsSection()
            default: return nil
            }
        }
    }
    
    private static func makeSectionHeader(absoluteOffset: CGPoint = .zero) -> NSCollectionLayoutBoundarySupplementaryItem {
        return .init(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(60)
            ),
            elementKind: HeaderView.reuseIdentifier,
            alignment: .topLeading,
            absoluteOffset: .init(x: absoluteOffset.x, y: absoluteOffset.y)
        )
    }
    
}

// MARK: - Countries Section

private extension HomeCompositionalLayout {
    static func makeCountryItem() -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets.trailing = 20
        
        return item
    }
    
    static func makeCountryGroup() -> NSCollectionLayoutGroup {
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.4),
                heightDimension: .fractionalHeight(0.06)
            ),
            subitems: [makeCountryItem()])
        
        return group
    }
    
    static func makeCountriesSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: makeCountryGroup())
        
        section.contentInsets.leading = 20
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [makeSectionHeader()]
        
        return section
    }
}

// MARK: - Latest Meals Section

private extension HomeCompositionalLayout {
    static func makeLatestMealItem() -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = .init(top: 10, leading: 10, bottom: 5, trailing: 50)
        
        return item
    }
    
    static func makeLatestMealGroup() -> NSCollectionLayoutGroup {
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.25)),
            subitems: [makeLatestMealItem()])
        
        return group
    }
    
    static func makeLatestMealsSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: makeLatestMealGroup())
        
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: -20)
        section.orthogonalScrollingBehavior = .paging
        section.boundarySupplementaryItems = [makeSectionHeader()]
        
        return section
    }
}

// MARK: - Ingredients Section

private extension HomeCompositionalLayout {
    static func makeIngredientItem() -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.5)
            )
        )
        item.contentInsets = .init(top: 0, leading: 15, bottom: 5, trailing: 0)
        
        return item
    }
    
    static func makeIngredientGroup() -> NSCollectionLayoutGroup {
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.37),
                heightDimension: .fractionalHeight(0.37)
            ),
            subitems: [makeIngredientItem()])
        
        return group
    }
    
    static func makeIngredientsSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: makeIngredientGroup())
        
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets.trailing = 15 / 2
        section.boundarySupplementaryItems = [makeSectionHeader(absoluteOffset: .init(x: 20, y: 0))]
        
        return section
    }
}

// MARK: - Random Meals Section

private extension HomeCompositionalLayout {
    static func makeRandomMealItem() -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .absolute(200)
            )
        )
        item.contentInsets = .init(top: 0, leading: 5, bottom: 5, trailing: 16)
        
        return item
    }
    
    static func makeRandomMealGroup() -> NSCollectionLayoutGroup {
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(1000)
            ),
            subitems: [makeRandomMealItem()]
        )
        
        return group
    }
    
    static func makeRandomMealsSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: makeRandomMealGroup())
        
        section.contentInsets.leading = 16
        section.boundarySupplementaryItems = [makeSectionHeader(absoluteOffset: .init(x: 4, y: 0))]

        return section
    }
}
