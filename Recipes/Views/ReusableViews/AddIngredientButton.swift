//
//  AddIngredientButton.swift
//  Recipes
//
//  Created by Ivan Semenov on 15.09.2023.
//

import UIKit

final class AddIngredientButton: UITableViewHeaderFooterView, ReusableView {

    var buttonHandler: (() -> Void)?

    var title: String? {
        didSet {
            button.setTitle(title, for: .normal)
        }
    }

    private let button = UIButton(type: .system)

    private enum Constants {
        static let insetSide = 70
        static let insetTopBottom = 10
        static let cornerRadius: CGFloat = 10
        static let titleInsetLeft: CGFloat = 18
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func handleButton() {
        buttonHandler?()
    }

    private func setup() {
        setupSuperView()
        setupButton()
    }

    private func setupSuperView() {
        if #available(iOS 14.0, *) {
            backgroundConfiguration = .clear()
        }
    }

    private func setupButton() {
        addSubview(button)
        button.titleLabel?.font = .addIngredientButton
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .appBlack
        button.titleEdgeInsets.left = Constants.titleInsetLeft
        button.setTitleColor(.lightGray, for: .normal)
        button.tintColor = .appOrange
        button.setImage(
            UIImage(.plusCircle)?.resizableImage(withCapInsets: .zero, resizingMode: .stretch),
            for: .normal
        )

        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)

        button.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.insetSide)
            make.top.bottom.equalToSuperview().inset(Constants.insetTopBottom)
        }
    }
}
