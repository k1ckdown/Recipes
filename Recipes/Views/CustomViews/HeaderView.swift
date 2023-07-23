//
//  HeaderView.swift
//  Recipes
//
//  Created by Ivan Semenov on 23.07.2023.
//

import UIKit

final class HeaderView: UIView {
    
    var headerTitle: String? {
        didSet {
            headerTitleLabel.text = headerTitle?.uppercased()
        }
    }
    
    private let headerTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(headerTitleLabel)
        
        headerTitleLabel.font = .headerTitle
        headerTitleLabel.textAlignment = .left
        headerTitleLabel.textColor = .lightGray
    
        headerTitleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}


