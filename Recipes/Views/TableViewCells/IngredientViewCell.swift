//
//  IngredientViewCell.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import UIKit

final class IngredientViewCell: UITableViewCell, ReuseIdentifier {
    
    private let nameLabel = UILabel()
    private let measureLabel = UILabel()
    private let ingredientImageView = UIImageView()
    
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
            by: .init(top: 10, left: 10, bottom: 10, right: 10)
        )
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
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .listCellBackground
    }
    
    private func setupIngredientImageView() {
        contentView.addSubview(ingredientImageView)
        
        ingredientImageView.clipsToBounds = true
        ingredientImageView.layer.cornerRadius = 20
        ingredientImageView.contentMode = .scaleToFill
        ingredientImageView.backgroundColor = .appBackground
        ingredientImageView.image = UIImage(named: "test")?.resizableImage(
            withCapInsets: .init(top: 10, left: 10, bottom: 10, right: 10),
            resizingMode: .stretch
        )
        
        ingredientImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(15)
            make.width.equalToSuperview().multipliedBy(0.2)
        }
    }
    
    private func setupNameLabel() {
        contentView.addSubview(nameLabel)
        
        nameLabel.text = "Matcha"
        nameLabel.textColor = .appWhite
        nameLabel.textAlignment = .center
        nameLabel.font = .ingredientDetailName
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(ingredientImageView.snp.trailing).offset(20)
        }
    }
    
    private func setupMeasureLabel() {
        contentView.addSubview(measureLabel)
        
        measureLabel.text = "1 teaspoon"
        measureLabel.textColor = .lightGray
        measureLabel.textAlignment = .center
        
        measureLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
}
