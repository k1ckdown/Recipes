//
//  AreaViewCell.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit

final class AreaViewCell: UICollectionViewCell, ReuseIdentifier {
    
    private let areaNameLabel = UILabel()
    
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
        layer.cornerRadius = 10
        backgroundColor = .appOrange
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
