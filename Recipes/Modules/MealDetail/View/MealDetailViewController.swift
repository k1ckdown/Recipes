//
//  MealDetailViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import UIKit
import SwiftUI

final class MealDetailViewController: UIViewController {
    
    private let mealImageView = UIImageView()
    private let ingredientsTableView = UITableView(frame: .zero, style: .insetGrouped)
    private let detailsSegmentedControl = UISegmentedControl(items: ["Ingredients", "Recipe"])
    
    private let dataSource: MealDetailDataSource = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        dataSource.configure(with: ingredientsTableView)
    }
    
    private func setup() {
        setupSuperView()
        setupMealImageView()
        setupDetailsSegmentedControl()
        setupIngredientsTableView()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .appBackground
    }
    
    private func setupMealImageView() {
        view.addSubview(mealImageView)
        
        mealImageView.clipsToBounds = true
        mealImageView.layer.cornerRadius = 20
        mealImageView.contentMode = .scaleToFill
        mealImageView.image = UIImage(named: "placeholder")
        
        mealImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
    }
    
    private func setupDetailsSegmentedControl() {
        view.addSubview(detailsSegmentedControl)
        
        detailsSegmentedControl.setTitleTextAttributes([.font: UIFont.detailTitle], for: .normal)
        
        detailsSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(mealImageView.snp.bottom).offset(50)
            make.leading.trailing.equalTo(mealImageView)
            make.height.equalTo(45)
        }
    }
    
    private func setupIngredientsTableView() {
        view.addSubview(ingredientsTableView)
        
        ingredientsTableView.rowHeight = 100
        ingredientsTableView.backgroundColor = .clear
        ingredientsTableView.separatorStyle = .none
        
        ingredientsTableView.snp.makeConstraints { make in
            make.top.equalTo(detailsSegmentedControl.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

struct MealDetail_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }

    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            return MealDetailViewController()
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

        }
    }
}
