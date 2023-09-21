//
//  CreateRecipeViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 04.09.2023.
//

import UIKit

final class CreateRecipeViewController: BaseViewController {
    
    var output: CreateRecipeViewOutput!
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let nameRecipeLabel = RecipeCreatingLabel()
    private let nameRecipeTextField = UITextField()
    
    private let descRecipeLabel = RecipeCreatingLabel()
    private let descRecipeTextView = UITextView()
    
    private let ingredientsLabel = RecipeCreatingLabel()
    private let ingredientsTableView = UITableView()
    private let addIngredientButton = AddIngredientButton()
    
    private let dataSource = CreateRecipeDataSource()
    
    private enum Constants {
        
        enum InputField {
            static let insetTop = 15
            static let insetSide = 12
        }
        
        enum CommonLabel {
            static let insetTop = 30
            static let insetLeading = 20
        }
        
        enum NameRecipeLabel {
            static let insetTop = 20
        }
        
        enum NameRecipeTextField {
            static let height = 60
            static let cornerRadius: CGFloat = 10
            static let flexibleSpaceWidth: CGFloat = 15
        }
        
        enum DescRecipeTextView {
            static let height = 290
            static let cornerRadius: CGFloat = 10
            static let contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        }
        
        enum IngredientsTableView {
            static let insetTop = 15
            static let rowHeight: CGFloat = 100
            static let sectionFooterHeight: CGFloat = 70
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        output.viewDidLoad()
    }
    
}

// MARK: - Actions

private extension CreateRecipeViewController {
    
    @objc
    func handleTapOnScroll() {
        view.endEditing(true)
    }
    
}

// MARK: - Private methods

private extension CreateRecipeViewController {
    
    func updateIngredientsTableConstraints(numberOfRows: Int) {
        ingredientsTableView.snp.remakeConstraints { make in
            make.top.equalTo(ingredientsLabel.snp.bottom).offset(Constants.IngredientsTableView.insetTop)
            make.height.equalTo(Constants.IngredientsTableView.sectionFooterHeight +
                                Constants.IngredientsTableView.rowHeight * CGFloat(numberOfRows))
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

// MARK: - Setup

private extension CreateRecipeViewController {
    
    func setup() {
        setupNavBar()
        setupScrollView()
        setupContentView()
        setupNameRecipeLabel()
        setupNameRecipeTextField()
        setupDescRecipeLabel()
        setupDescRecipeTextView()
        setupIngredientsLabel()
        setupIngredientsTableView()
        setupAddIngredientButton()
    }
    
    func setupNavBar() {
        navigationItem.title = output.sceneTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.keyboardDismissMode = .onDrag
        scrollView.showsVerticalScrollIndicator = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnScroll))
        scrollView.addGestureRecognizer(tapGesture)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupContentView() {
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func setupNameRecipeLabel() {
        contentView.addSubview(nameRecipeLabel)
        
        nameRecipeLabel.text = output.nameRecipeTitle
        nameRecipeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.NameRecipeLabel.insetTop)
            make.leading.equalToSuperview().offset(Constants.CommonLabel.insetLeading)
        }
    }
    
    func setupNameRecipeTextField() {
        contentView.addSubview(nameRecipeTextField)
        
        nameRecipeTextField.delegate = self
        nameRecipeTextField.font = .nameRecipeTextField
        nameRecipeTextField.borderStyle = .none
        nameRecipeTextField.textColor = .appWhite
        nameRecipeTextField.tintColor = .appOrange
        nameRecipeTextField.backgroundColor = .appGray
        nameRecipeTextField.layer.cornerRadius = Constants.NameRecipeTextField.cornerRadius
        nameRecipeTextField.addFlexibleSpace(width: Constants.NameRecipeTextField.flexibleSpaceWidth)
        
        let foregroundColor = UIColor.appLightGray ?? .lightGray
        nameRecipeTextField.attributedPlaceholder = .init(
            string: output.nameRecipePlaceholder,
            attributes: [.foregroundColor: foregroundColor]
        )
        
        nameRecipeTextField.snp.makeConstraints { make in
            make.top.equalTo(nameRecipeLabel.snp.bottom).offset(Constants.InputField.insetTop)
            make.leading.trailing.equalToSuperview().inset(Constants.InputField.insetSide)
            make.height.equalTo(Constants.NameRecipeTextField.height)
        }
    }
    
    func setupDescRecipeLabel() {
        contentView.addSubview(descRecipeLabel)
        
        descRecipeLabel.text = output.descRecipeTitle
        descRecipeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameRecipeTextField.snp.bottom).offset(Constants.CommonLabel.insetTop)
            make.leading.equalToSuperview().offset(Constants.CommonLabel.insetLeading)
        }
    }
    
    func setupDescRecipeTextView() {
        contentView.addSubview(descRecipeTextView)
        
        descRecipeTextView.delegate = self
        descRecipeTextView.font = .recipeText
        descRecipeTextView.textColor = .appWhite
        descRecipeTextView.tintColor = .appOrange
        descRecipeTextView.backgroundColor = .appGray
        descRecipeTextView.text = output.descRecipePlaceholder
        descRecipeTextView.showsVerticalScrollIndicator = false
        descRecipeTextView.layer.cornerRadius = Constants.DescRecipeTextView.cornerRadius
        descRecipeTextView.contentInset = Constants.DescRecipeTextView.contentInset
        
        descRecipeTextView.snp.makeConstraints { make in
            make.top.equalTo(descRecipeLabel.snp.bottom).offset(Constants.InputField.insetTop)
            make.leading.trailing.equalToSuperview().inset(Constants.InputField.insetSide)
            make.height.equalTo(Constants.DescRecipeTextView.height)
        }
    }
    
    func setupIngredientsLabel() {
        contentView.addSubview(ingredientsLabel)
        
        ingredientsLabel.text = output.ingredientsTilte
        ingredientsLabel.snp.makeConstraints { make in
            make.top.equalTo(descRecipeTextView.snp.bottom).offset(Constants.CommonLabel.insetTop)
            make.leading.equalToSuperview().offset(Constants.CommonLabel.insetLeading)
        }
    }
    
    func setupIngredientsTableView() {
        contentView.addSubview(ingredientsTableView)
        
        ingredientsTableView.delegate = self
        ingredientsTableView.rowHeight = Constants.IngredientsTableView.rowHeight
        ingredientsTableView.separatorStyle = .none
        ingredientsTableView.showsVerticalScrollIndicator = false
        ingredientsTableView.sectionFooterHeight = Constants.IngredientsTableView.sectionFooterHeight
        dataSource.configure(with: ingredientsTableView)
        
        ingredientsTableView.snp.makeConstraints { make in
            make.top.equalTo(ingredientsLabel.snp.bottom).offset(Constants.IngredientsTableView.insetTop)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setupAddIngredientButton() {
        addIngredientButton.title = output.addIngredientTitle
        addIngredientButton.buttonHandler = { [weak self] in
            self?.output.addIngredientButtonTapped()
        }
    }
    
}

// MARK: - UITextFieldDelegate

extension CreateRecipeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        output.didEndEditingNameRecipe(textField.text)
    }
    
}

// MARK: - UITextViewDelegate

extension CreateRecipeViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        output.didEndEditingDescRecipe(textView.text)
    }
    
}

// MARK: - UITableViewDelegate

extension CreateRecipeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        addIngredientButton
    }
    
}


// MARK: - CreateRecipeViewInput

extension CreateRecipeViewController: CreateRecipeViewInput {
    
    func refreshList(items: [IngredientCellModel]) {
        dataSource.updateItems(items)
        ingredientsTableView.reloadData()
        updateIngredientsTableConstraints(numberOfRows: items.count)
    }
    
}
