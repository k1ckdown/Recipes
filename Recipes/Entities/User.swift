//
//  User.swift
//  Recipes
//
//  Created by Ivan Semenov on 14.07.2023.
//

import Foundation

struct User {
    var id: String
    var username: String
    var email: String
    var dateOfBirth: Date?
    var sex: Sex?
}

enum Sex: CaseIterable {
    case male
    case female
}
