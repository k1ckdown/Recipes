//
//  ProfileViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import UIKit
import SwiftUI

final class ProfileViewController: UIViewController {
    
    private let noAccountView = NoAccountView()
    
    private let profilePictureImageView = UIImageView()
    private let backgroundProfileImageView = UIImageView()
    
    private let usernameLabel = UILabel()
    private let editButton = UIButton(type: .system)
    
    private let optionsStackView = UIStackView()
    
    private let personalInfoButton = ProfileButton(style: .personalInfo)
    private let myRecipesButton = ProfileButton(style: .myRecipes)
    private let logoutButton = ProfileButton(style: .logout)
    
    var output: ProfileViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    @objc
    private func handlePersonalInfoButton() {
        
    }
    
    @objc
    private func handleMyRecipesButton() {
        
    }
    
    @objc
    private func handleLogoutButton() {
        
    }
    
    private func setup() {
        setupSuperView()
        setupNoAccountView()
//        setupBackgroundProfileImageView()
//        setupProfilePictureImageView()
//        setupUsernameLabel()
//        setupEditButton()
//        setupOptionsStackView()
//        setupPersonalInfoButton()
//        setupMyRecipesButton()
//        setupLogoutButton()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .appBackground
    }
    
    private func setupNoAccountView() {
        view.addSubview(noAccountView)
        
        noAccountView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBackgroundProfileImageView() {
        view.addSubview(backgroundProfileImageView)
        
        backgroundProfileImageView.image = UIImage(named: "background-profile")
        
        backgroundProfileImageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.27)
        }
    }
    
    private func setupProfilePictureImageView() {
        view.addSubview(profilePictureImageView)
        
        profilePictureImageView.contentMode = .scaleToFill
        profilePictureImageView.clipsToBounds = true
        profilePictureImageView.layer.cornerRadius = 125 / 2
        profilePictureImageView.layer.borderWidth = 15
        profilePictureImageView.layer.borderColor = UIColor.appBackground?.cgColor
        profilePictureImageView.image = UIImage(named: "profile-picture")
        
        profilePictureImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(125)
            make.top.equalTo(backgroundProfileImageView.snp.bottom).offset(-60)
        }
    }
    
    private func setupUsernameLabel() {
        view.addSubview(usernameLabel)
        
        usernameLabel.text = "John Smith"
        usernameLabel.textAlignment = .center
        usernameLabel.textColor = .appWhite
        usernameLabel.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        
        usernameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profilePictureImageView.snp.bottom).offset(10)
        }
    }
    
    private func setupEditButton() {
        view.addSubview(editButton)
        
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.lightGray, for: .normal)
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        editButton.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(3)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupOptionsStackView() {
        view.addSubview(optionsStackView)
        
        optionsStackView.spacing = 20
        optionsStackView.axis = .vertical
        optionsStackView.distribution = .fillEqually
        
        optionsStackView.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
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
        logoutButton.addTarget(self, action: #selector(handleLogoutButton), for: .touchUpInside)
    }
    
}

// MARK: - ProfileViewInput

extension ProfileViewController: ProfileViewInput {
    
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }

    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            let vc: ProfileViewController = DIContainer.shared.resolve()
            return UINavigationController(rootViewController: vc)
        }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

        }
    }
}
