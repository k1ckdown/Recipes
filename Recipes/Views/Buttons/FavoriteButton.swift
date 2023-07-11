//
//  FavoriteButton.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import UIKit

final class FavoriteButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        resetAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateAppearance() {
        isHighlighted ? applyAppearance() : resetAppearance()
    }
    
    private func applyAppearance() {
        tintColor = .systemRed
        setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
    private func resetAppearance() {
        tintColor = .gray
        setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
}
