//
//  HeaderView.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit

final class HeaderView: UICollectionReusableView, ReuseIdentifier {
    
    var headerText: String? {
        didSet {
            label.text = headerText
        }
    }
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    private func setup() {
        addSubview(label)
        label.font = .sectionHeader
        label.textColor = .sectionHeader
    }
}
