//
//  DatePickerCell.swift
//  Recipes
//
//  Created by Ivan Semenov on 23.07.2023.
//

import UIKit

final class DatePickerCell: UITableViewCell, ReuseIdentifier {
    
    private(set) var datePicker = UIDatePicker()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .clear
        selectionStyle = .none
        setupDatePicker()
    }
    
    private func setupDatePicker() {
        addSubview(datePicker)
        
        datePicker.datePickerMode = .date

        if #available(iOS 15, *) {
            datePicker.date = .now
        } else {
            datePicker.date = .distantPast
        }
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview()
        }
    }
    
}