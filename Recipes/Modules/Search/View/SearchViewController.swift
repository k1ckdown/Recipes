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
        setupMealTableView()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .appBackground
    }
    
    private func setupMealTableView() {
        view.addSubview(mealTableView)
        
        mealTableView.rowHeight = 150
        mealTableView.backgroundColor = .clear
        
        mealTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}

// MARK: - SearchViewInput

extension SearchViewController: SearchViewInput {
    
    func refreshList() {
        mealTableView.reloadData()
    }
    
}

//struct Search_Previews: PreviewProvider {
//    static var previews: some View {
//        Container().edgesIgnoringSafeArea(.all)
//    }
//
//    struct Container: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> some UIViewController {
//            let viewController: SearchViewController = DIContainer.shared.resolve(argument: SearchListType.byArea(area: "American"))
//            return UINavigationController(rootViewController: viewController)
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//        }
//    }
//}
