//
//  FavoritesViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    var output: FavoritesViewOutput!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillAppear()
    }
    
}

// MARK: - FavoritesViewInput

extension FavoritesViewController: FavoritesViewInput {
    
}
