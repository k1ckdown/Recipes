//
//  MealViewCell.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import UIKit

final class MealViewCell: UITableViewCell, ReuseIdentifier {
    
    private let mealNameLabel = UILabel()
    private let areaNameLabel = UILabel()
    private let categoryNameLabel = UILabel()
    private let mealImageView = UIImageView()
    private let detailStackView = UIStackView()
    
    private enum Constants {
        
            enum ContentView {
                static let cornerRadius: CGFloat = 15
                static let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            }
            
            enum MealImageView {
                static let insetLeading = 10
                static let insetTopBottom = 10
                static let multiplierWidth = 0.3
                static let capInsets: CGFloat = 10
                static let cornerRadius: CGFloat = 30
            }
            
            enum DetailStackView {
                static let insetLeading = 20
                static let insetTrailing = 10
                static let insetTopBottom = 15
                static let spacing: CGFloat = 7
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
        
        mealNameLabel.text = nil
        areaNameLabel.text = nil
        categoryNameLabel.text = nil
        mealImageView.image = nil
    }
    
    func configure(with model: MealCellModel) {
        mealNameLabel.text = model.mealName
        areaNameLabel.text = model.areaName
        categoryNameLabel.text = model.categoryName
        mealImageView.setImage(model.imageUrl, inset: Constants.MealImageView.capInsets)
    }
    
    private func setup() {
        setupSuperView()
        setupContentView()
        setupMealImageView()
        setupDetailStackView()
        setupMealNameLabel()
        setupCategoryNameLabel()
        setupAreaNameLabel()
    }
    
    private func setupSuperView() {
        backgroundColor = .clear
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .appGray
        contentView.layer.cornerRadius = Constants.ContentView.cornerRadius
    }
    
    private func setupMealImageView() {
        contentView.addSubview(mealImageView)
        
        mealImageView.clipsToBounds = true
        mealImageView.contentMode = .scaleToFill
        mealImageView.layer.cornerRadius = Constants.MealImageView.cornerRadius
        
        mealImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.MealImageView.insetLeading)
            make.top.bottom.equalToSuperview().inset(Constants.MealImageView.insetTopBottom)
            make.width.equalToSuperview().multipliedBy(Constants.MealImageView.multiplierWidth)
        }
    }
    
    private func setupDetailStackView() {
        contentView.addSubview(detailStackView)
        
        detailStackView.axis = .vertical
        detailStackView.alignment = .leading
        detailStackView.distribution = .fill
        detailStackView.backgroundColor = .clear
        detailStackView.spacing = Constants.DetailStackView.spacing
        
        detailStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Constants.DetailStackView.insetTopBottom)
            make.leading.equalTo(mealImageView.snp.trailing).offset(Constants.DetailStackView.insetLeading)
            make.trailing.equalToSuperview().inset(Constants.DetailStackView.insetTrailing)
        }
    }
    
    private func setupMealNameLabel() {
        detailStackView.addArrangedSubview(mealNameLabel)
        mealNameLabel.textColor = .appWhite
        mealNameLabel.font = .mealNameSearchList
    }
    
    private func setupCategoryNameLabel() {
        detailStackView.addArrangedSubview(categoryNameLabel)
        categoryNameLabel.textColor = .lightGray
    }
    
    private func setupAreaNameLabel() {
        detailStackView.addArrangedSubview(areaNameLabel)
        areaNameLabel.textColor = .lightGray
    }
    
}
