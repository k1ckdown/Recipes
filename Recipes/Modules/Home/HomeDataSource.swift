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
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(
            CountryViewCell.self,
            forCellWithReuseIdentifier: CountryViewCell.reuseIdentifier
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

// MARK: - UICollectionViewDataSource

extension HomeDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = HomeSection(rawValue: indexPath.section) else { return .init() }
        
        switch section {
        case .countries:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CountryViewCell.reuseIdentifier,
                    for: indexPath
                ) as? CountryViewCell
            else { return .init() }
            
            return cell
            
        case .latestMeals:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FoodViewCell.reuseIdentifier,
                    for: indexPath
                ) as? FoodViewCell
            else { return .init() }
            
            return cell
            
        case .ingredients:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FoodViewCell.reuseIdentifier,
                    for: indexPath
                ) as? FoodViewCell
            else { return .init() }
            
            return cell
            
        case .randomMeals:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FoodViewCell.reuseIdentifier,
                    for: indexPath
                ) as? FoodViewCell
            else { return .init() }
            
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let section = HomeSection(rawValue: indexPath.section) else { return .init() }
        
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

// MARK: - UICollectionViewDelegate

extension HomeDataSource: UICollectionViewDelegate {
    
}
