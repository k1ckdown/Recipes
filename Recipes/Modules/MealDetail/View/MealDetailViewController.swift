//
//  MealDetailViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import UIKit
import SwiftUI

final class MealDetailViewController: UIViewController {
    
    weak var output: MealDetailViewOutput! {
        didSet {
            dataSource.output = output
        }
    }
    
    private let mealNameLabel = UILabel()
    private let mealImageView = UIImageView()
    private let recipeTextView = UITextView()
    private let ingredientsTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private lazy var detailsSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: output.getSegmentedItems())
        return segmentedControl
    }()
    
    private let dataSource: MealDetailDataSource = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        dataSource.configure(with: ingredientsTableView)
        output.viewDidLoad()
    }
    
    @objc
    private func handleDetailsSegmentedControl(_ sender: UISegmentedControl) {
        output.didSelectSegment(at: sender.selectedSegmentIndex)
    }
    
    private func setup() {
        setupMealNameLabel()
        setupSuperView()
        setupMealImageView()
        setupDetailsSegmentedControl()
        setupIngredientsTableView()
        setupRecipeTextView()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .appBackground
    }
    
    private func setupMealNameLabel() {
        view.addSubview(mealNameLabel)
        
        mealNameLabel.textAlignment = .center
        mealNameLabel.textColor = .appWhite
        mealNameLabel.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        
        mealNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
        }
    }
    
    private func setupMealImageView() {
        view.addSubview(mealImageView)
        
        mealImageView.clipsToBounds = true
        mealImageView.layer.cornerRadius = 20
        mealImageView.contentMode = .scaleToFill
        mealImageView.image = UIImage(named: "placeholder")
        
        mealImageView.snp.makeConstraints { make in
            make.top.equalTo(mealNameLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
    }
    
    private func setupDetailsSegmentedControl() {
        view.addSubview(detailsSegmentedControl)
        
        detailsSegmentedControl.backgroundColor = .appGray
        detailsSegmentedControl.selectedSegmentTintColor = .appBlack
        detailsSegmentedControl.selectedSegmentIndex = output.getStartSelectedSegment()
        detailsSegmentedControl.setTitleTextAttributes(
            [.font: UIFont.detailSegmentTitle, .foregroundColor: UIColor.appWhite ?? .white],
            for: .normal
        )
        detailsSegmentedControl.addTarget(self, action: #selector(handleDetailsSegmentedControl), for: .valueChanged)
        
        detailsSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(mealImageView.snp.bottom).offset(40)
            make.leading.trailing.equalTo(mealImageView)
            make.height.equalTo(50)
        }
    }
    
    private func setupIngredientsTableView() {
        view.addSubview(ingredientsTableView)
        
        ingredientsTableView.rowHeight = 100
        ingredientsTableView.backgroundColor = .clear
        ingredientsTableView.separatorStyle = .none
        ingredientsTableView.contentInset.top = -15
        ingredientsTableView.isHidden = true
        ingredientsTableView.showsVerticalScrollIndicator = false
        
        ingredientsTableView.snp.makeConstraints { make in
            make.top.equalTo(detailsSegmentedControl.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupRecipeTextView() {
        view.addSubview(recipeTextView)
        
        recipeTextView.font = .recipeText
        recipeTextView.textColor = .appWhite
        recipeTextView.tintColor = .lightGray
        recipeTextView.backgroundColor = .appBlack
        recipeTextView.isHidden = true
        recipeTextView.isEditable = false
        recipeTextView.showsVerticalScrollIndicator = false
        recipeTextView.layer.cornerRadius = 20
        recipeTextView.contentInset = . init(top: 15, left: 15, bottom: 15, right: 15)
        
        recipeTextView.snp.makeConstraints { make in
            make.top.equalTo(detailsSegmentedControl.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(25)
        }
    }
    
}

extension MealDetailViewController: MealDetailViewInput {
    
    func refreshList() {
        ingredientsTableView.reloadData()
    }
    
    func updateRecipeText(_ text: String?) {
        recipeTextView.text = text
    }
    
    func updateMealName(_ title: String?) {
        mealNameLabel.text = title
    }
    
    func updateMealImage(imageUrl: String) {
        mealImageView.kf.setImage(with: URL(string: imageUrl))
    }
    
    func showRecipeText() {
        recipeTextView.isHidden = false
        ingredientsTableView.isHidden = true
    }
    
    func showIngredientList() {
        recipeTextView.isHidden = true
        ingredientsTableView.isHidden = false
    }
    
}

//struct MealDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        Container().edgesIgnoringSafeArea(.all)
//    }
//
//    struct Container: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> some UIViewController {
//            return UINavigationController(rootViewController: MealDetailAssembly.assemble(argument: "52772"))
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//
//        }
//    }
//}
