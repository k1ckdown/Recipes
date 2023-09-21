//
//  CreateRecipeDataSource.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.09.2023.
//

import UIKit

final class CreateRecipeDataSource: NSObject {
    
    private var items = [IngredientCellModel]()
    
    func updateItems(_ items: [IngredientCellModel]) {
        self.items = items
    }
    
    func configure(with tableView: UITableView) {
        tableView.dataSource = self
        
        tableView.register(
            IngredientViewCell.self,
            forCellReuseIdentifier: IngredientViewCell.reuseIdentifier
        )
    }
    
}

// MARK: - UITableViewDataSource

extension CreateRecipeDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: IngredientViewCell.reuseIdentifier,
                for: indexPath
            ) as? IngredientViewCell
        else { return .init() }
        
        cell.configure(with: items[indexPath.row])
        return cell
    }
    
}
