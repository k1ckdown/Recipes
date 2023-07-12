//
//  MealTableDataSource.swift
//  Recipes
//
//  Created by Ivan Semenov on 12.07.2023.
//

import UIKit

final class MealTableDataSource: NSObject {
    
    var mealCellModels = [MealCellModel]()
    
    func configure(with tableView: UITableView) {
        tableView.dataSource = self
        
        tableView.register(
            MealViewCell.self,
            forCellReuseIdentifier: MealViewCell.reuseIdentifier
        )
    }
    
}

extension MealTableDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mealCellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MealViewCell.reuseIdentifier,
                for: indexPath
            ) as? MealViewCell
        else { return .init() }
        
        cell.configure(with: mealCellModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
}
