//
//  FoodViewCell.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit

final class FoodViewCell: UICollectionViewCell, ReuseIdentifier {
    
    private let nameLabel = UILabel()
    private let foodImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupSuperView()
        setupFoodImageView()
        setupNameLabel()
    }
    
    private func setupSuperView() {
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    private func setupFoodImageView() {
        addSubview(foodImageView)
        
        foodImageView.image = UIImage(named: "default")
        foodImageView.contentMode = .scaleToFill
        
        foodImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        
        nameLabel.text = "Chocolate Raspberry Brownies"
        nameLabel.textColor = .appWhite
        nameLabel.textAlignment = .center
        nameLabel.layer.cornerRadius = 5
        nameLabel.layer.masksToBounds = true
        nameLabel.backgroundColor = .appBackground
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
        }
    }
    
}
