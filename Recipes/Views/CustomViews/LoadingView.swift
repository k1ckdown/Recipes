//
//  LoadingView.swift
//  Recipes
//
//  Created by Ivan Semenov on 10.07.2023.
//

import UIKit

final class LoadingView: UIActivityIndicatorView {
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        color = .appWhite
        hidesWhenStopped = true
    }
    
}

