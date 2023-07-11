//
//  SearchViewInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 09.07.2023.
//

import Foundation

protocol SearchViewInput: AnyObject, LoadingDisplayable {
    func refreshList()
}
