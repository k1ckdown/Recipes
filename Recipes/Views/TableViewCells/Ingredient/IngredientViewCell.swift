//
//  IngredientViewCell.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import UIKit

final class IngredientViewCell: UITableViewCell {
    
    private let nameLabel = UILabel()
    private let measureLabel = UILabel()
    private let ingredientImageView = UIImageView()
    
    private enum Constants {
        
            enum ContentView {
                static let cornerRadius: CGFloat = 20
                static let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            }
            
            enum IngredientImageView {
                static let insetLeading = 15
                static let insetTopBottom = 10
                static let multiplierWidth = 0.2
                static let capInsets: CGFloat = 10
                static let cornerRadius: CGFloat = 20
            }
            
            enum NameLabel {
                static let insetLeading = 15
                static let multiplierWidth = 0.35
            }
            
            enum MeasureLabel {
                static let insetTrailing = -20
                static let multiplierWidth = 0.3
            }
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(
            by: Constants.ContentView.insets
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        measureLabel.text = nil
        ingredientImageView.image = nil
    }
    
    func configure(with model: IngredientCellModel) {
        measureLabel.text = model.measure
        nameLabel.text = model.nameIngredient
        ingredientImageView.setImage(model.imageUrl,
                                     inset: Constants.IngredientImageView.capInsets)
    }
    
    private func setup() {
        setupSuperView()
        setupContentView()
        setupIngredientImageView()
        setupNameLabel()
        setupMeasureLabel()
    }
    
    private func setupSuperView() {
        backgroundColor = .clear
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .appBlack
        contentView.layer.cornerRadius = Constants.ContentView.cornerRadius
    }
    
    private func setupIngredientImageView() {
        contentView.addSubview(ingredientImageView)
        
        ingredientImageView.clipsToBounds = true
        ingredientImageView.contentMode = .scaleToFill
        ingredientImageView.backgroundColor = .appBackground
        ingredientImageView.layer.cornerRadius = Constants.IngredientImageView.cornerRadius
        
        ingredientImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.IngredientImageView.insetTopBottom)
            make.leading.equalToSuperview().offset(Constants.IngredientImageView.insetLeading)
            make.width.equalToSuperview().multipliedBy(Constants.IngredientImageView.multiplierWidth)
        }
    }
    
    private func setupNameLabel() {
        contentView.addSubview(nameLabel)
        
        nameLabel.textColor = .appWhite
        nameLabel.textAlignment = .left
        nameLabel.font = .ingredientDetailName
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(ingredientImageView.snp.trailing).offset(Constants.NameLabel.insetLeading)
            make.width.equalToSuperview().multipliedBy(Constants.NameLabel.multiplierWidth)
        }
    }
    
    private func setupMeasureLabel() {
        contentView.addSubview(measureLabel)
        
        measureLabel.textColor = .lightGray
        measureLabel.textAlignment = .right
        measureLabel.font = .measureTitle
        
        measureLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(Constants.MeasureLabel.insetTrailing)
            make.width.equalToSuperview().multipliedBy(Constants.MeasureLabel.multiplierWidth)
        }
    }
    
}
