//
//  UserDTO.swift
//  Recipes
//
//  Created by Ivan Semenov on 24.07.2023.
//

import Foundation

struct UserDTO: Codable {
    var id: String
    var username: String
    var email: String
    var dateOfBirth: Date?
    var sex: SexDTO?
}

enum SexDTO: Codable {
    case male
    case female
}
