//
//  FavoritesViewInput.swift
//  Recipes
//
//  Created by Ivan Semenov on 11.07.2023.
//

import Foundation

protocol FavoritesViewInput: AnyObject {
    func refreshList()
    func showIntro()
    func hideIntro()
}
