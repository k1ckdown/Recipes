//
//  LoadingDisplayable.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import UIKit

protocol LoadingDisplayable {
    var loadingView: LoadingView { get }
    
    func showLoader()
    func hideLoader()
}

extension LoadingDisplayable {
    
    func showLoader() {
        loadingView.startAnimating()
    }
    
    func hideLoader() {
        loadingView.stopAnimating()
    }
}

extension LoadingDisplayable where Self: UIViewController {
    
    func setupLoadingView() {
        self.view.addSubview(loadingView)
        
        loadingView.snp.makeConstraints { make in
            make.center.edges.equalToSuperview()
        }
    }
    
}
