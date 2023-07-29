//
//  MealListViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import UIKit

final class MealListViewController: BaseViewController {
    
    var output: MealListViewOutput! {
        didSet {
            dataSource.output = output
        }
    }
    
    private lazy var mealCollectionView: UICollectionView = {
        let layout = MealListCompositionalLayout.createLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        return collectionView
    }()
    
    private let dataSource: MealListDataSource = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .appWhite
        
        setup()
        output.viewDidLoad()
        dataSource.configure(with: mealCollectionView)
    }
    
    private func setup() {
        setupMealCollectionView()
    }
    
    private func setupMealCollectionView() {
        view.addSubview(mealCollectionView)
        
        mealCollectionView.delegate = self
        mealCollectionView.backgroundColor = .clear
        mealCollectionView.showsVerticalScrollIndicator = false
        
        mealCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

// MARK: - MealListViewInput

extension MealListViewController: MealListViewInput {
    
    func refreshList() {
        mealCollectionView.reloadData()
    }
    
    func updateNavigationTitle(_ title: String) {
        navigationItem.title = title
    }
    
}

// MARK: - UICollectionViewDelegate

extension MealListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.didSelectItem(at: indexPath)
    }
}
