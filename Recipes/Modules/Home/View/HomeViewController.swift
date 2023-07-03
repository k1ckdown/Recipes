//
//  HomeViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var output: HomeViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupSuperView()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .systemIndigo
    }
}

extension HomeViewController: HomeViewInput {
    
}
