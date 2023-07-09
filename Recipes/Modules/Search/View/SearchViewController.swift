//
//  SearchViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import UIKit
import SwiftUI

final class SearchViewController: UIViewController {
    
    var output: SearchViewOutput! {
        didSet {
            dataSource.output = output
        }
    }
    
    private let mealSearchBar = UISearchBar()
    private let mealTableView = UITableView()
    
    private let dataSource: SearchDataSource = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        dataSource.configure(with: mealTableView)
        output.viewDidLoad()
    }
    
    private func setup() {
        setupSuperView()
        setupMealSearchBar()
        setupMealTableView()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .appBackground
    }
    
    private func setupMealSearchBar() {
        view.addSubview(mealSearchBar)
        
        mealSearchBar.tintColor = .lightGray
        mealSearchBar.barTintColor = .appBackground
        mealSearchBar.placeholder = "Search recipes"
        mealSearchBar.showsSearchResultsButton = true
        mealSearchBar.searchTextField.textColor = .appWhite
        mealSearchBar.searchTextField.backgroundColor = .appGray
        
        mealSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        mealSearchBar.searchTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(50)
        }

    }
    
    private func setupMealTableView() {
        view.addSubview(mealTableView)
        
        mealTableView.rowHeight = 150
        mealTableView.backgroundColor = .clear
        mealTableView.separatorStyle = .none
        mealTableView.contentInset.top = 15
        mealTableView.showsVerticalScrollIndicator = false
        
        mealTableView.snp.makeConstraints { make in
            make.top.equalTo(mealSearchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

// MARK: - SearchViewInput

extension SearchViewController: SearchViewInput {
    
    func refreshList() {
        mealTableView.reloadData()
    }
    
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }

    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            let viewController: SearchViewController = DIContainer.shared.resolve()
            return UINavigationController(rootViewController: viewController)
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

        }
    }
}
