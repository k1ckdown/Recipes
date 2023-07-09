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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mealNameLabel.text = nil
        areaNameLabel.text = nil
        categoryNameLabel.text = nil
        mealImageView.image = nil
    }
    
    func configure(with model: MealCellModel) {
        mealNameLabel.text = model.mealName
        areaNameLabel.text = areaNameLabel.text
        categoryNameLabel.text = model.categoryName
        mealImageView.setImage(model.imageUrl, inset: 10)
    }
    
    private func setup() {
        setupMealImageView()
    }
    
    private func setupMealImageView() {
        contentView.addSubview(mealImageView)
        
        mealImageView.contentMode = .scaleToFill
        mealImageView.clipsToBounds = true
        mealImageView.layer.cornerRadius = 10
        
        mealImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview().inset(10)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
    }
    
}
