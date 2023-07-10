//
//  MealDetailViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 07.07.2023.
//

import UIKit

final class MealDetailViewController: UIViewController {
    
    var output: MealDetailViewOutput! {
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
    
    private enum Constants {
        
            enum MealNameLabel {
                static let insetSide = 15
            }
            
            enum MealImageView {
                static let insetTop = 40
                static let insetSide = 40
                static let multiplierHeight = 0.25
                static let cornerRadius: CGFloat = 20
            }
            
            enum DetailsSegmentedControl {
                static let height = 50
                static let insetTop = 40
            }
            
            enum IngredientsTableView {
                static let rowHeight: CGFloat = 100
                static let contentInsetTop: CGFloat = -15
            }
            
            enum RecipeTextView {
                static let insetSide = 20
                static let insetTopBottom = 18
                static let cornerRadius: CGFloat = 20
                static let contentInset: UIEdgeInsets = .init(top: 15, left: 15, bottom: 15, right: 15)
            }
        
    }
    
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
        mealNameLabel.font = .mealDetailTitle
        
        mealNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.MealNameLabel.insetSide)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupMealImageView() {
        view.addSubview(mealImageView)
        
        mealImageView.clipsToBounds = true
        mealImageView.contentMode = .scaleToFill
        mealImageView.image = UIImage(named: "placeholder")
        mealImageView.layer.cornerRadius = Constants.MealImageView.cornerRadius
        
        mealImageView.snp.makeConstraints { make in
            make.top.equalTo(mealNameLabel.snp.bottom).offset(Constants.MealImageView.insetTop)
            make.leading.trailing.equalToSuperview().inset(Constants.MealImageView.insetSide)
            make.height.equalToSuperview().multipliedBy(Constants.MealImageView.multiplierHeight)
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
            make.top.equalTo(mealImageView.snp.bottom).offset(Constants.DetailsSegmentedControl.insetTop)
            make.leading.trailing.equalTo(mealImageView)
            make.height.equalTo(Constants.DetailsSegmentedControl.height)
        }
    }
    
    private func setupIngredientsTableView() {
        view.addSubview(ingredientsTableView)
        
        ingredientsTableView.rowHeight = Constants.IngredientsTableView.rowHeight
        ingredientsTableView.backgroundColor = .clear
        ingredientsTableView.separatorStyle = .none
        ingredientsTableView.contentInset.top = Constants.IngredientsTableView.contentInsetTop
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
        recipeTextView.layer.cornerRadius = Constants.RecipeTextView.cornerRadius
        recipeTextView.contentInset = Constants.RecipeTextView.contentInset
        
        recipeTextView.snp.makeConstraints { make in
            make.top.equalTo(detailsSegmentedControl.snp.bottom).offset(Constants.RecipeTextView.insetTopBottom)
            make.leading.trailing.equalToSuperview().inset(Constants.RecipeTextView.insetSide)
            make.bottom.equalToSuperview().inset(Constants.RecipeTextView.insetTopBottom)
        }
    }
    
}

// MARK: - MealDetailViewInput

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
