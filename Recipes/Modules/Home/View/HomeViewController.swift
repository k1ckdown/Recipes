//
//  HomeViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.07.2023.
//

import UIKit
import SnapKit

import SwiftUI

final class HomeViewController: UIViewController {
    
    var output: HomeViewOutput? {
        didSet {
            dataSource.output = output
        }
    }
    
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
    
    private func setup() {
        setupSuperView()
        setupFoodCollectionView()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .appBackground
    }
    
    private func setupFoodCollectionView() {
        view.addSubview(foodCollectionView)
        
        foodCollectionView.delegate = self
        foodCollectionView.backgroundColor = .clear
        
        foodCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - HomeViewInput

extension HomeViewController: HomeViewInput {
    func refreshCollection() {
        foodCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.didSelectItem(at: indexPath)
    }
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        Container().edgesIgnoringSafeArea(.all)
//    }
//
//    struct Container: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> some UIViewController {
//            return UINavigationController(rootViewController: HomeAssembly.assemble())
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//        }
//    }
//}
