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
    
    private let mealSearchBar = UISearchBar()
    private let mealTableView = UITableView()
    
    private let dataSource: SearchDataSource = .init()
    
    private enum Constants {
        
            enum MealSearchBar {
                static let height = 60
                static let insetSide = 20
            }
            
            enum SearchTextField {
                static let height = 50
            }
            
            enum MealTableView {
                static let rowHeight: CGFloat = 150
                static let contentInsetTop: CGFloat = 15
            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        dataSource.configure(with: mealTableView)
        output.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func setup() {
        setupSuperView()
        setupMealSearchBar()
        setupMealTableView()
    }
    
    private func setupSuperView() {
        view.isUserInteractionEnabled = true
        view.backgroundColor = .appBackground
    }
    
    private func setupMealSearchBar() {
        view.addSubview(mealSearchBar)
        
        mealSearchBar.delegate = self
        mealSearchBar.tintColor = .lightGray
        mealSearchBar.barTintColor = .appBackground
        mealSearchBar.placeholder = output.searchPlaceholder
        mealSearchBar.searchTextField.textColor = .appWhite
        mealSearchBar.searchTextField.backgroundColor = .appGray
        
        mealSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(Constants.MealSearchBar.insetSide)
            make.height.equalTo(Constants.MealSearchBar.height)
        }
        
        mealSearchBar.searchTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(Constants.SearchTextField.height)
        }

    }
    
    private func setupMealTableView() {
        view.addSubview(mealTableView)
        
        mealTableView.delegate = self
        mealTableView.separatorStyle = .none
        mealTableView.backgroundColor = .clear
        mealTableView.keyboardDismissMode = .onDrag
        mealTableView.showsVerticalScrollIndicator = false
        mealTableView.rowHeight = Constants.MealTableView.rowHeight
        mealTableView.contentInset.top = Constants.MealTableView.contentInsetTop
        
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

// MARK: UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        output.didPerformSearch(searchBar.text)
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectRow(at: indexPath)
    }
    
}

//struct Search_Previews: PreviewProvider {
//    static var previews: some View {
//        Container().edgesIgnoringSafeArea(.all)
//    }
//
//    struct Container: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> some UIViewController {
//            let viewController: SearchViewController = DIContainer.shared.resolve()
//            return UINavigationController(rootViewController: viewController)
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//        }
//    }
//}
