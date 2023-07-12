//
//  FavoritesDataSource.swift
//  Recipes
//
//  Created by Ivan Semenov on 12.07.2023.
//

import UIKit

final class FavoritesDataSource: NSObject {
    var output: FavoritesViewOutput!
    
    func configure(with tableView: UITableView) {
        tableView.dataSource = self
        
        tableView.register(
            MealViewCell.self,
            forCellReuseIdentifier: MealViewCell.reuseIdentifier
        )
    }
    
}

extension FavoritesDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MealViewCell.reuseIdentifier,
                for: indexPath
            ) as? MealViewCell
        else { return .init() }
        
        cell.configure(with: output.mealCellModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        output.removeFavoriteMeal(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
    
}
