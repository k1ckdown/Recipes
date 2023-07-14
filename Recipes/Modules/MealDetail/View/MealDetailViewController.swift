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
    
    private(set) var loadingView = LoadingView()
    private let mealNameLabel = UILabel()
    private let mealImageView = UIImageView()
    private let recipeTextView = UITextView()
    private let watchVideoButton = UIButton()
    private let favoriteBarButton = UIBarButtonItem()
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
                static let insetTop = 25
                static let insetSide = 40
                static let multiplierHeight = 0.25
                static let cornerRadius: CGFloat = 20
            }
            
            enum DetailsSegmentedControl {
                static let height = 50
                static let insetTop = 25
            }
            
            enum IngredientsTableView {
                static let rowHeight: CGFloat = 100
                static let contentInsetTop: CGFloat = -15
                static let contentInsetBottom: CGFloat = 15
            }
            
            enum RecipeTextView {
                static let insetSide = 20
                static let insetTopBottom = 18
                static let cornerRadius: CGFloat = 20
                static let contentInset: UIEdgeInsets = .init(top: 15, left: 15, bottom: 55, right: 15)
            }
        
            enum WatchVideoButton {
                static let height = 47
                static let insetBottom = 25
                static let multiplierWidth = 0.5
                static let cornerRadius: CGFloat = 15
                static let titleInsets: UIEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        dataSource.configure(with: ingredientsTableView)
        output.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hideTabBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.showTabBar()
    }
    
    @objc
    private func handleDetailsSegmentedControl(_ sender: UISegmentedControl) {
        output.didSelectSegment(at: sender.selectedSegmentIndex)
    }
    
    @objc
    private func handleFavoriteButton() {
        output.didTapOnFavoriteButton()
    }
    
    @objc
    private func handleWatchVideoButton() {
        output.didTapOnWatchVideoButton()
    }
    
    private func setup() {
        setupMealNameLabel()
        setupSuperView()
        setupMealImageView()
        setupDetailsSegmentedControl()
        setupIngredientsTableView()
        setupRecipeTextView()
        setupWatchVideoButton()
        setupFavoriteBarButton()
        setupLoadingView()
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
        ingredientsTableView.contentInset.bottom = Constants.IngredientsTableView.contentInsetBottom
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
    
    private func setupWatchVideoButton() {
        view.addSubview(watchVideoButton)
    
        watchVideoButton.tintColor = .appWhite
        watchVideoButton.layer.cornerRadius = Constants.WatchVideoButton.cornerRadius
        watchVideoButton.backgroundColor = .appOrange
        watchVideoButton.isHidden = true
        watchVideoButton.setTitle("Watch Video", for: .normal)
        watchVideoButton.setTitleColor(.appWhite, for: .normal)
        watchVideoButton.titleEdgeInsets = Constants.WatchVideoButton.titleInsets
        watchVideoButton.titleLabel?.font = .watchVideoTitle
        watchVideoButton.setImage(
            UIImage(systemName: "play.circle")?.resizableImage(withCapInsets: .zero, resizingMode: .stretch),
            for: .normal
        )
        watchVideoButton.addTarget(self, action: #selector(handleWatchVideoButton), for: .touchUpInside)
        
        watchVideoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.WatchVideoButton.height)
            make.width.equalToSuperview().multipliedBy(Constants.WatchVideoButton.multiplierWidth)
            make.bottom.equalToSuperview().inset(Constants.WatchVideoButton.insetBottom)
            
        }
    }
    
    private func setupFavoriteBarButton() {
        favoriteBarButton.target = self
        favoriteBarButton.action = #selector(handleFavoriteButton)
        navigationItem.rightBarButtonItem = favoriteBarButton
        resetFavoriteAppearance()
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
        mealImageView.setImage(imageUrl)
    }
    
    func showWatchVideoButton() {
        watchVideoButton.isHidden = false
    }
    
    func showRecipeText() {
        recipeTextView.isHidden = false
        ingredientsTableView.isHidden = true
    }
    
    func showIngredientList() {
        recipeTextView.isHidden = true
        ingredientsTableView.isHidden = false
    }
    
    func applyFavoriteAppearance() {
        favoriteBarButton.tintColor = .systemRed
        favoriteBarButton.image = UIImage(systemName: "heart.fill")
    }
    
    func resetFavoriteAppearance() {
        favoriteBarButton.tintColor = .systemGray
        favoriteBarButton.image = UIImage(systemName: "heart")
    }
    
}
