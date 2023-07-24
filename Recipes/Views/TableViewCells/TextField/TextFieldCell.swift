//
//  TextFieldCell.swift
//  Recipes
//
//  Created by Ivan Semenov on 23.07.2023.
//

import UIKit

final class TextFieldCell: UITableViewCell, ReuseIdentifier {
    
    private(set) var textField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        textField.tag = 0
        textField.text = nil
        textField.placeholder = nil
    }
    
    func configure(with model: TextFieldCellModel) {
        textField.tag = model.tag
        textField.text = model.value
        textField.placeholder = model.placeholder
    }
    
    private func setup() {
        backgroundColor = .clear
        selectionStyle = .none
        setupTextField()
    }
    
    private func setupTextField() {
        contentView.addSubview(textField)
        
        textField.textColor = .appWhite
        textField.tintColor = .appOrange
        textField.backgroundColor = .clear
        textField.isEnabled = true
        
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
