//
//  SegmentedControlCell.swift
//  Recipes
//
//  Created by Ivan Semenov on 23.07.2023.
//

import UIKit

final class SegmentedControlCell: UITableViewCell, ReusableView {
    
    private(set) var segmentedControl: UISegmentedControl? {
        didSet {
            setup()
        }
    }
    
    func configure(with model: SegmentedControlCellModel) {
        segmentedControl = .init(items: model.items)
        segmentedControl?.selectedSegmentIndex = model.selectedIndex ?? -1
    }
    
    private func setup() {
        backgroundColor = .clear
        selectionStyle = .none
        setupSegmentedControl()
    }
    
    private func setupSegmentedControl() {
        guard let segmentedControl = segmentedControl else { return }
        
        contentView.addSubview(segmentedControl)
        
        segmentedControl.backgroundColor = .appGray
        segmentedControl.selectedSegmentTintColor = .darkGray
        
        segmentedControl.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview()
        }
    }
    
}
