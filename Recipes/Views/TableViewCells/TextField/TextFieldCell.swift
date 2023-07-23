//
//  TextFieldCell.swift
//  Recipes
//
//  Created by Ivan Semenov on 23.07.2023.
//

import UIKit

final class TextFieldCell: UITableViewCell, ReuseIdentifier {
    
    private let textField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: TextFieldCellModel) {
        textField.placeholder = model.placeholder
    }
    
    private func setup() {
        backgroundColor = .clear
        selectionStyle = .none
        setupTextField()
    }
    
    private func setupTextField() {
        addSubview(textField)
        
        textField.textColor = .appWhite
        textField.tintColor = .appOrange
        textField.backgroundColor = .clear
        
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
