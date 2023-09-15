//
//  CreateRecipeDataSource.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.09.2023.
//

import UIKit

final class CreateRecipeDataSource: NSObject {
	var output: CreateRecipeViewOutput!

	func configure(with tableView: UITableView) {
		tableView.dataSource = self

		tableView.register(
			IngredientViewCell.self,
			forCellReuseIdentifier: IngredientViewCell.reuseIdentifier
		)

		tableView.register(
			AddIngredientButton.self,
			forHeaderFooterViewReuseIdentifier: AddIngredientButton.reuseIdentifier
		)
	}
}

// MARK: - UITableViewDataSource

extension CreateRecipeDataSource: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		output.numberOfRows()
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard
			let cell = tableView.dequeueReusableCell(
				withIdentifier: IngredientViewCell.reuseIdentifier,
				for: indexPath
			) as? IngredientViewCell
		else { return .init() }

		cell.configure(with: output.ingredientCellModels[indexPath.row])
		return cell
	}

}
