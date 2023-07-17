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
    
    private enum Constants {
        
            enum FoodImageView {
                static let capInsets: CGFloat = 5
                static let cornerRadius: CGFloat = 10
            }
            
            enum NameLabel {
                static let height = 40
                static let insetLeading = 10
                static let insetBottom = -10
                static let multiplierWidth = 0.8
                static let cornerRadius: CGFloat = 5
            }
        
    }
    
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
        layer.cornerRadius = 0
        foodImageView.image = nil
        nameLabel.isHidden = false
        nameLabel.backgroundColor = nil
        nameLabel.snp.removeConstraints()
        foodImageView.snp.removeConstraints()
    }
    
    func configure(with model: FoodCellModel) {
        layer.cornerRadius = model.foodType.cornerRadius
        backgroundColor = model.foodType.backgroundColor
        nameLabel.text = model.foodName
        nameLabel.font = model.foodType.font
        nameLabel.isHidden = !model.foodType.shouldShowName
        nameLabel.backgroundColor = model.foodType.labelBackgroundColor
        foodImageView.setImage(model.imageUrl, inset: Constants.FoodImageView.capInsets)
        setupConstraints(for: model.foodType)
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
        
        foodImageView.clipsToBounds = true
        foodImageView.layer.masksToBounds = false
        foodImageView.contentMode = .scaleToFill
        foodImageView.layer.cornerRadius = Constants.FoodImageView.cornerRadius
    }
    
    private func setupNameLabel() {
        addSubview(nameLabel)
        
        nameLabel.textColor = .appWhite
        nameLabel.textAlignment = .center
        nameLabel.layer.masksToBounds = true
        nameLabel.layer.cornerRadius = Constants.NameLabel.cornerRadius
    }
    
    private func setupConstraints(for type: FoodCellStyle) {
        foodImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(type.imageHeightMultiplier)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.NameLabel.insetLeading)
            make.width.equalToSuperview().multipliedBy(Constants.NameLabel.multiplierWidth)
            make.height.equalTo(Constants.NameLabel.height)
        }
        
        switch type {
        case .latestMeal:
            nameLabel.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(Constants.NameLabel.insetBottom)
            }
        case .category, .defaultMeal:
            nameLabel.snp.makeConstraints { make in
                make.top.equalTo(foodImageView.snp.bottom)
            }
        }
    }
    
}
