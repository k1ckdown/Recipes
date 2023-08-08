//
//  AreaViewCell.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit

final class AreaViewCell: UICollectionViewCell, ReusableView {
    
    private let areaNameLabel = UILabel()
    
    private enum Constants {
        
            enum SuperView {
                static let cornerRadius: CGFloat = 10
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
        areaNameLabel.text = nil
    }
    
    func configure(with model: AreaCellModel) {
        areaNameLabel.text = model.areaName
    }
    
    private func setup() {
        setupSuperView()
        setupCountryNameLabel()
    }
    
    private func setupSuperView() {
        backgroundColor = .appOrange
        layer.cornerRadius = Constants.SuperView.cornerRadius
    }
    
    private func setupCountryNameLabel() {
        addSubview(areaNameLabel)
        
        areaNameLabel.font = .areaName
        areaNameLabel.textColor = .appWhite
        
        areaNameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
