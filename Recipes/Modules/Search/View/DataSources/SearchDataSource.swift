//
//  SearchDataSource.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import UIKit

final class SearchDataSource: NSObject {
    var output: SearchViewOutput!
    
    func configure(with tableView: UITableView) {
        tableView.dataSource = self
        
        tableView.register(
            MealViewCell.self,
            forCellReuseIdentifier: MealViewCell.reuseIdentifier
        )
    }
    
}

extension SearchDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.numberOfItems()
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
    
}
