//
//  MealListDataSource.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import UIKit

final class MealListDataSource: NSObject {
    var output: MealListViewOutput!
    
    func configure(with collectionView: UICollectionView) {
        collectionView.dataSource = self
        
        collectionView.register(
            FoodViewCell.self,
            forCellWithReuseIdentifier: FoodViewCell.reuseIdentifier
        )
    }
    
}

extension MealListDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FoodViewCell.reuseIdentifier,
                for: indexPath
            ) as? FoodViewCell
        else { return .init() }
        
        cell.configure(with: output.mealCellModels[indexPath.item])
        return cell
    }
    
}
