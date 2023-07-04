//
//  CountryCell.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit

final class CountryCell: UICollectionViewCell, ReuseIdentifier {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .orange
        layer.cornerRadius = 10
    }
}
