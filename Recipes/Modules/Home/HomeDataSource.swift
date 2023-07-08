//
//  HomeDataSource.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit

final class HomeDataSource: NSObject {
    var output: HomeViewOutput!
    
    func configure(with collectionView: UICollectionView) {
        collectionView.dataSource = self
        
        collectionView.register(
            AreaViewCell.self,
            forCellWithReuseIdentifier: AreaViewCell.reuseIdentifier
        )
        
        collectionView.register(
            FoodViewCell.self,
            forCellWithReuseIdentifier: FoodViewCell.reuseIdentifier
        )
        
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: HeaderView.reuseIdentifier,
            withReuseIdentifier: HeaderView.reuseIdentifier
        )
    }
}

extension HomeDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return output.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.numberOfItems(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = HomeSection(rawValue: indexPath.section) else { return .init() }
        
        switch section {
        case .areas:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: AreaViewCell.reuseIdentifier,
                    for: indexPath
                ) as? AreaViewCell
            else { return .init() }
            
            cell.configure(with: output.areaCellModels[indexPath.item])
            return cell
            
        case .latestMeals:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FoodViewCell.reuseIdentifier,
                    for: indexPath
                ) as? FoodViewCell
            else { return .init() }
            
            cell.configure(with: output.latestMealCellModels[indexPath.item])
            return cell
            
        case .categories:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FoodViewCell.reuseIdentifier,
                    for: indexPath
                ) as? FoodViewCell
            else { return .init() }
            
            cell.configure(with: output.categoryCellModels[indexPath.item])
            return cell
            
        case .popularMeals:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FoodViewCell.reuseIdentifier,
                    for: indexPath
                ) as? FoodViewCell
            else { return .init() }
            
            cell.configure(with: output.popularMealCellModels[indexPath.item])
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let section = output.section(at: indexPath.section)
        
        guard
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.reuseIdentifier,
                for: indexPath
            ) as? HeaderView
        else { return .init() }

        header.headerText = section.header
        return header
    }
    
}
