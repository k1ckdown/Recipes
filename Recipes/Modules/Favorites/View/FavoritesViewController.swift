//
//  FavoritesViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    var output: FavoritesViewOutput! {
        didSet {
            dataSource.output = output
        }
    }
    
    private let contentView = UIView()
    private let noAccountView = NoAccountView()
    
    private let mealTableView = MealTableView()
    private let dataSource: FavoritesDataSource = .init()
    
    private let introView = UIView()
    private let introImageView = UIImageView()
    private let introLabel = UILabel()
    
    private enum Constants {
        
            enum IntroImageView {
                static let insetTop: CGFloat = 200
                static let multiplierWidth: CGFloat = 0.7
                static let multiplierHeight: CGFloat = 0.35
            }
            
            enum IntroLabel {
                static let insetTop: CGFloat = 22
            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = output.sceneTitle
        
        setup()
        dataSource.configure(with: mealTableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBackBarButton()
    }
    
    private func setup() {
        setupSuperView()
        setupContentView()
        setupNoAccountView()
        setupMealTableView()
        setupIntroView()
        setupIntroImageView()
        setupIntroLabel()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .appBackground
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        
        contentView.isHidden = true
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNoAccountView() {
        view.addSubview(noAccountView)
        
        noAccountView.isHidden = true
        
        noAccountView.completionHandler = { [weak self] in
            self?.output.didTapOnLogIn()
        }
        
        noAccountView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupMealTableView() {
        view.addSubview(mealTableView)
        
        mealTableView.delegate = self
        mealTableView.isHidden = true
        
        mealTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupIntroView() {
        view.addSubview(introView)
    
        introView.backgroundColor = .clear
        introView.isHidden = true
        
        introView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupIntroImageView() {
        introView.addSubview(introImageView)
        
        introImageView.image = UIImage(named: "heart")
        introImageView.contentMode = .scaleToFill
        
        introImageView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(Constants.IntroImageView.multiplierHeight)
            make.top.equalToSuperview().offset(Constants.IntroImageView.insetTop)
            make.width.equalToSuperview().multipliedBy(Constants.IntroImageView.multiplierWidth)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupIntroLabel() {
        introView.addSubview(introLabel)
        
        introLabel.textColor = .appWhite
        introLabel.text = output.introTitle()
        introLabel.font = .favoritesIntroTitle
        
        introLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(introImageView.snp.bottom).offset(Constants.IntroLabel.insetTop)
        }
    }
    
    private func setupBackBarButton() {
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButton.tintColor = .appWhite
        navigationItem.backBarButtonItem = backBarButton
    }
    
}

// MARK: - FavoritesViewInput

extension FavoritesViewController: FavoritesViewInput {
    
    func refreshList() {
        mealTableView.reloadData()
    }
    
    func showIntro() {
        introView.isHidden = false
        mealTableView.isHidden = true
    }
    
    func hideIntro() {
        introView.isHidden = true
        mealTableView.isHidden = false
    }
    
    func showContent() {
        contentView.isHidden = false
        noAccountView.isHidden = true
    }
    
    func hideContent() {
        introView.isHidden = true
        mealTableView.isHidden = true
        contentView.isHidden = true
        noAccountView.isHidden = false
    }
    
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectRow(at: indexPath)
    }
    
}
