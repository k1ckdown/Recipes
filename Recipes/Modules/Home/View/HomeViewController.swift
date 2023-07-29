//
//  HomeViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit
import SnapKit

final class HomeViewController: BaseViewController {
    
    var output: HomeViewOutput? {
        didSet {
            dataSource.output = output
        }
    }
    
    private(set) var loadingView = LoadingView()
    private lazy var foodCollectionView: UICollectionView = {
        let layout = HomeCompositionalLayout.createLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        return collectionView
    }()
    
    private let dataSource: HomeDataSource = HomeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        dataSource.configure(with: foodCollectionView)
        output?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBackBarButton()
    }
    
    private func setup() {
        setupFoodCollectionView()
        setupLoadingView()
    }
    
    private func setupFoodCollectionView() {
        view.addSubview(foodCollectionView)
        
        foodCollectionView.delegate = self
        foodCollectionView.isHidden = true
        foodCollectionView.backgroundColor = .clear
        foodCollectionView.showsVerticalScrollIndicator = false
        
        foodCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBackBarButton() {
        let backBarButtonItem = UIBarButtonItem(image: .init(), style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .appWhite
        navigationItem.backBarButtonItem = backBarButtonItem
    }
}

// MARK: - HomeViewInput

extension HomeViewController: HomeViewInput {
    
    func refreshCollection() {
        foodCollectionView.reloadData()
    }
    
    func hideLoader() {
        loadingView.stopAnimating()
        foodCollectionView.isHidden = false
    }
    
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.didSelectItem(at: indexPath)
    }
    
}
