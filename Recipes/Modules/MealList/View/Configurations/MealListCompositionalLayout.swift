//
//  MealListCompositionalLayout.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import UIKit

enum MealListCompositionalLayout {
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return .init(section: makeMealListSection())
    }
}

private extension MealListCompositionalLayout {
    static func makeMealItem() -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .absolute(200)
            )
        )
        item.contentInsets = .init(top: 0, leading: 5, bottom: 5, trailing: 16)
        
        return item
    }
    
    static func makeMealGroup() -> NSCollectionLayoutGroup {
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(1000)
            ),
            subitems: [makeMealItem()]
        )
        
        return group
    }
    
    static func makeMealListSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: makeMealGroup())
        
        section.contentInsets.top = 20
        section.contentInsets.leading = 16

        return section
    }
}

