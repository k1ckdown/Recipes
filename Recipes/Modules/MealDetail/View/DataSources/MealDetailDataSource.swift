//
//  MealDetailDataSource.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import UIKit

final class MealDetailDataSource: NSObject {
    var output: MealDetailViewOutput!
    
    func configure(with tableView: UITableView) {
        tableView.dataSource = self
        
        tableView.register(
            IngredientViewCell.self,
            forCellReuseIdentifier: IngredientViewCell.reuseIdentifier
        )
    }
}

extension MealDetailDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.numberOfItems()
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
