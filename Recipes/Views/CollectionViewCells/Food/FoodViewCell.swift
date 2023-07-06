//
//  FoodViewCell.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit
import Kingfisher

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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        nameLabel.font = nil
        backgroundColor = nil
        foodImageView.image = nil
        nameLabel.isHidden = false
        nameLabel.backgroundColor = nil
        nameLabel.snp.removeConstraints()
        foodImageView.snp.removeConstraints()
    }
    
    func configure(with model: FoodCellModel) {
        nameLabel.text = model.foodName
        nameLabel.font = model.foodType.font
        nameLabel.isHidden = !model.foodType.shouldShowName
        nameLabel.backgroundColor = model.foodType.backgroundColor
        foodImageView.kf.setImage(with: URL(string: model.imageUrl),
                                  placeholder: UIImage(named: "placeholder"))
        
        foodImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(model.foodType.imageHeightMultiplier)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
        }
        
        switch model.foodType {
        case .latestMeal:
            nameLabel.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-10)
            }
        case .ingredient, .popularMeal:
            nameLabel.snp.makeConstraints { make in
                make.top.equalTo(foodImageView.snp.bottom)
            }
        }
        
        if model.foodType == .ingredient {
            layer.cornerRadius = 10
            backgroundColor = .appGray
        }
    }
    
    private func setup() {
        setupSuperView()
        setupFoodImageView()
        setupNameLabel()
    }
    
    private func setupSuperView() {
        clipsToBounds = true
    }
    
    private func setupFoodImageView() {
        addSubview(foodImageView)
        
        foodImageView.contentMode = .scaleToFill
        foodImageView.layer.cornerRadius = 10
        foodImageView.layer.masksToBounds = false
        foodImageView.clipsToBounds = true
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        
        nameLabel.textColor = .appWhite
        nameLabel.textAlignment = .center
        nameLabel.layer.cornerRadius = 5
        nameLabel.layer.masksToBounds = true
    }
    
}
