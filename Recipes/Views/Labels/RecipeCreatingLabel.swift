//
//  RecipeCreatingLabel.swift
//  Recipes
//
//  Created by Ivan Semenov on 10.09.2023.
//

import UIKit

final class RecipeCreatingLabel: UILabel {

	init() {
		super.init(frame: .zero)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setup() {
		textColor = .appWhite
		textAlignment = .left
		font = .recipeCreatingLabel
	}

}
