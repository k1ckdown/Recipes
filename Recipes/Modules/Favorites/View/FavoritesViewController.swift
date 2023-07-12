//
//  FavoritesViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    var output: FavoritesViewOutput! {
        didSet {
            dataSource.output = output
        }
    }
    
    private let mealTableView = MealTableView()
    private let dataSource: FavoritesDataSource = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        dataSource.configure(with: mealTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBackBarButton()
    }
    
    private func setup() {
        setupSuperView()
        setupMealTableView()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .appBackground
    }
    
    private func setupMealTableView() {
        view.addSubview(mealTableView)
        
        mealTableView.delegate = self
        
        mealTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBackBarButton() {
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButton.tintColor = .appWhite
        navigationItem.backBarButtonItem = backBarButton
    }
    
}

// MARK: - FavoritesViewInput

extension FavoritesViewController: FavoritesViewInput {
    
    func refreshList() {
        mealTableView.reloadData()
    }
    
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectRow(at: indexPath)
    }
    
}
