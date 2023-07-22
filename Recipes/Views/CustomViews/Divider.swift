//
//  Divider.swift
//  Recipes
//
//  Created by Ivan Semenov on 22.07.2023.
//

import UIKit

final class Divider: UIView {
    
    var titleLabel: String? {
        didSet {
            label.text = titleLabel
        }
    }
    
    private let label = UILabel()
    private enum Constants {
        static let spacing = 8
        static let heightSeparator = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupSuperView()
        setupLabel()
        setupLeftSeparator()
        setupRightSeparator()
    }
    
    private func setupSuperView() {
        backgroundColor = .clear
    }
    
    private func setupLabel() {
        addSubview(label)
        
        label.textColor = .appWhite
        label.textAlignment = .center
        label.font = .separatorLabel
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupLeftSeparator() {
        let separatorView = makeSeparatorView()
        addSubview(separatorView)
        
        separatorView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.height.equalTo(Constants.heightSeparator)
            make.trailing.equalTo(label.snp.leading).offset(-Constants.spacing)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupRightSeparator() {
        let separatorView = makeSeparatorView()
        addSubview(separatorView)
        
        separatorView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.height.equalTo(Constants.heightSeparator)
            make.leading.equalTo(label.snp.trailing).offset(Constants.spacing)
            make.centerY.equalToSuperview()
        }
    }
    
    private func makeSeparatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }
}
