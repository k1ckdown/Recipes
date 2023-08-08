//
//  AlertPresentable.swift
//  Recipes
//
//  Created by Ivan Semenov on 20.07.2023.
//

import UIKit

protocol AlertPresentable {
    func presentErrorAlert(with description: String)
}

extension AlertPresentable where Self: Router {
    
    func presentErrorAlert(with description: String) {
        presentAlert(title: "Error",
                     message: description,
                     actions: [UIAlertAction(title: "OK", style: .default)])
    }
    
    private func presentAlert(title: String? = nil, message: String? = nil, actions: [UIAlertAction] = []) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alertController.addAction($0) }
        view?.present(alertController, animated: true)
    }
    
}
