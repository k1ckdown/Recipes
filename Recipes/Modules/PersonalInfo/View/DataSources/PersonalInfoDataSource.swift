//
//  PersonalInfoDataSource.swift
//  Recipes
//
//  Created by Ivan Semenov on 23.07.2023.
//

//import UIKit
//
//final class PersonalInfoDataSource: NSObject {
//    var output: PersonalInfoViewOutput!
//
//    func configure(with tableView: UITableView) {
//        tableView.dataSource = self
//
//        tableView.register(
//            TextFieldCell.self,
//            forCellReuseIdentifier: TextFieldCell.reuseIdentifier
//        )
//    }
//
//}
//
//extension PersonalInfoDataSource: UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        2
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard
//            let cell = tableView.dequeueReusableCell(
//                withIdentifier: TextFieldCell.reuseIdentifier,
//                for: indexPath
//            ) as? TextFieldCell
//        else { return .init() }
//
//        cell.configure(with: <#T##TextFieldCellModel#>)
//        return cell
//    }
//
//}
