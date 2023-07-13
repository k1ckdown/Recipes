//
//  ProfileViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 13.07.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    var output: ProfileViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemIndigo
    }
    
}

// MARK: - ProfileViewInput

extension ProfileViewController: ProfileViewInput {
    
}
