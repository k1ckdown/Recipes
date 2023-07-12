//
//  SearchViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import UIKit

final class SearchViewController: UIViewController {
    
    var output: SearchViewOutput! {
        didSet {
            dataSource.output = output
        }
    }
    
    private(set) var loadingView = LoadingView()
    private let mealSearchController = UISearchController()
    private let mealTableView = MealTableView()
    
    private let dataSource: SearchDataSource = .init()
    
    private enum Constants {
        
            enum MealSearchBar {
                static let insetSide = 10
            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        dataSource.configure(with: mealTableView)
        output.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = output.sceneTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBackBarButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationItem.title = nil
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func setup() {
        setupNavigationItem()
        setupSuperView()
        setupMealSearchBar()
        setupMealTableView()
        setupLoadingView()
    }
    
    private func setupNavigationItem() {
        navigationItem.searchController = mealSearchController
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    private func setupSuperView() {
        view.isUserInteractionEnabled = true
        view.backgroundColor = .appBackground
    }
    
    private func setupMealSearchBar() {
        mealSearchController.searchBar.delegate = self
        mealSearchController.searchBar.tintColor = .appOrange
        mealSearchController.searchBar.barTintColor = .appBackground
        mealSearchController.searchBar.showsCancelButton = true
        mealSearchController.searchBar.placeholder = output.searchPlaceholder
        mealSearchController.searchBar.searchTextField.textColor = .appWhite
        mealSearchController.searchBar.searchTextField.backgroundColor = .appGray
    }
    
    private func setupMealTableView() {
        view.addSubview(mealTableView)
        
        mealTableView.delegate = self
        
        mealTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupBackBarButton() {
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButton.tintColor = .appWhite
        navigationItem.backBarButtonItem = backBarButton
    }
    
}

// MARK: - SearchViewInput

extension SearchViewController: SearchViewInput {
    
    func refreshList() {
        mealTableView.reloadData()
    }
    
}

// MARK: UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        output.didPerformSearch(searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectRow(at: indexPath)
    }
    
}
