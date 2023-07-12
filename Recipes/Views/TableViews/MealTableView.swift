//
//  MealTableView.swift
//  Recipes
//
//  Created by Ivan Semenov on 12.07.2023.
//

import UIKit

final class MealTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        rowHeight = 150
        contentInset.top = 15
        separatorStyle = .none
        backgroundColor = .clear
        keyboardDismissMode = .onDrag
        showsVerticalScrollIndicator = false
    }
    
}
