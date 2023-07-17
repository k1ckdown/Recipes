//
//  ProfileViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    var output: ProfileViewOutput!
    
    private(set) var loadingView = LoadingView()
    private let contentView = UIView()
    private let noAccountView = NoAccountView()
    
    private let profilePictureImageView = UIImageView()
    private let backgroundProfileImageView = UIImageView()
    
    private let usernameLabel = UILabel()
    private let editButton = UIButton(type: .system)
    
    private let optionsStackView = UIStackView()
    
    private let personalInfoButton = ProfileButton(style: .personalInfo)
    private let myRecipesButton = ProfileButton(style: .myRecipes)
    private let logoutButton = ProfileButton(style: .logout)
    
    private enum Constants {
            
            enum UsernameLabel {
                static let insetTop = 10
            }
        
            enum BackgroundProfileImageView {
                static let multiplierHeight = 0.27
            }
            
            enum EditButton {
                static let insetTop = 3
            }
            
            enum OptionsStackView {
                static let insetTop = 20
                static let insetSide = 15
                static let insetBottom = 30
                static let spacing: CGFloat = 20
            }
            
            enum ProfilePictureImageView {
                static let insetTop = -60
                static let size: CGFloat = 125
                static let borderWidth: CGFloat = 15
                static let cornerRadius: CGFloat = size / 2
            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBackBarButton()
    }
    
    @objc
    private func handlePersonalInfoButton() {
        
    }
    
    @objc
    private func handleMyRecipesButton() {
        
    }
    
    @objc
    private func handleLogOutButton() {
        output.didTapOnLogOutButton()
    }
    
    private func setup() {
        setupSuperView()
        setupLoadingView()
        setupContentView()
        setupNoAccountView()
        setupBackgroundProfileImageView()
        setupProfilePictureImageView()
        setupUsernameLabel()
        setupEditButton()
        setupOptionsStackView()
        setupPersonalInfoButton()
        setupMyRecipesButton()
        setupLogoutButton()
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
    
    private func setupBackgroundProfileImageView() {
        contentView.addSubview(backgroundProfileImageView)
        
        backgroundProfileImageView.image = UIImage(named: "background-profile")
        
        backgroundProfileImageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(Constants.BackgroundProfileImageView.multiplierHeight)
        }
    }
    
    private func setupProfilePictureImageView() {
        contentView.addSubview(profilePictureImageView)
        
        profilePictureImageView.contentMode = .scaleToFill
        profilePictureImageView.clipsToBounds = true
        profilePictureImageView.layer.cornerRadius = Constants.ProfilePictureImageView.cornerRadius
        profilePictureImageView.layer.borderWidth = Constants.ProfilePictureImageView.borderWidth
        profilePictureImageView.layer.borderColor = UIColor.appBackground?.cgColor
        profilePictureImageView.image = UIImage(named: "profile-picture")
        
        profilePictureImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(Constants.ProfilePictureImageView.size)
            make.top.equalTo(backgroundProfileImageView.snp.bottom).offset(Constants.ProfilePictureImageView.insetTop)
        }
    }
    
    private func setupUsernameLabel() {
        contentView.addSubview(usernameLabel)
        
        usernameLabel.textAlignment = .center
        usernameLabel.textColor = .appWhite
        usernameLabel.font = .usernameLabel
        
        usernameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profilePictureImageView.snp.bottom).offset(Constants.UsernameLabel.insetTop)
        }
    }
    
    private func setupEditButton() {
        contentView.addSubview(editButton)
        
        editButton.setTitle(output.editButtonTitle, for: .normal)
        editButton.titleLabel?.font = .editProfileButton
        editButton.setTitleColor(.lightGray, for: .normal)
        
        editButton.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(Constants.EditButton.insetTop)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupOptionsStackView() {
        contentView.addSubview(optionsStackView)
        
        optionsStackView.axis = .vertical
        optionsStackView.distribution = .fillEqually
        optionsStackView.spacing = Constants.OptionsStackView.spacing
        
        optionsStackView.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(Constants.OptionsStackView.insetTop)
            make.leading.trailing.equalToSuperview().inset(Constants.OptionsStackView.insetSide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.OptionsStackView.insetBottom)
        }
    }
    
    private func setupPersonalInfoButton() {
        optionsStackView.addArrangedSubview(personalInfoButton)
        personalInfoButton.addTarget(self, action: #selector(handlePersonalInfoButton), for: .touchUpInside)
    }
    
    private func setupMyRecipesButton() {
        optionsStackView.addArrangedSubview(myRecipesButton)
        myRecipesButton.addTarget(self, action: #selector(handleMyRecipesButton), for: .touchUpInside)
    }
    
    private func setupLogoutButton() {
        optionsStackView.addArrangedSubview(logoutButton)
        logoutButton.addTarget(self, action: #selector(handleLogOutButton), for: .touchUpInside)
    }
    
    private func setupBackBarButton() {
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButton.tintColor = .appWhite
        navigationItem.backBarButtonItem = backBarButton
    }
    
}

// MARK: - ProfileViewInput

extension ProfileViewController: ProfileViewInput {
    
    func showContent() {
        contentView.isHidden = false
        noAccountView.isHidden = true
    }
    
    func hideContent() {
        contentView.isHidden = true
        noAccountView.isHidden = false
    }
    
    func updateUsername(_ username: String) {
        usernameLabel.text = username
    }
    
}
