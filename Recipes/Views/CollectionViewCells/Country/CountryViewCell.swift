//
//  CountryViewCell.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit

final class CountryViewCell: UICollectionViewCell, ReuseIdentifier {
    
    private let countryNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupSuperView()
        setupCountryNameLabel()
    }
    
    private func setupSuperView() {
        layer.cornerRadius = 10
        backgroundColor = .appBlue
    }
    
    private func setupCountryNameLabel() {
        addSubview(countryNameLabel)
        
        countryNameLabel.text = "Italia"
        countryNameLabel.font = .countryName
        countryNameLabel.textColor = .appWhite
        
        countryNameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
