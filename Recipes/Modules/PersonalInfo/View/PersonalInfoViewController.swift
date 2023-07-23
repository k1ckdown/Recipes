//
//  PersonalInfoViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 22.07.2023.
//

import UIKit

final class PersonalInfoViewController: UIViewController {

    var output: PersonalInfoViewOutput!
    
    private let infoTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    @objc
    private func handleDateOfBirthPicker(sender: UIDatePicker) {
        
    }
    
    @objc
    private func handleSexSegmentedControl(sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }
    
    private func setup() {
        setupSuperView()
        setupInfoTableView()
    }
    
    private func setupSuperView() {
        view.backgroundColor = .appBackground
    }
    
    private func setupInfoTableView() {
        view.addSubview(infoTableView)
        
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.separatorStyle = .none
        infoTableView.backgroundColor = .clear
        infoTableView.isScrollEnabled = false
        
        infoTableView.register(
            TextFieldCell.self,
            forCellReuseIdentifier: TextFieldCell.reuseIdentifier
        )
        
        infoTableView.register(
            SegmentedControlCell.self,
            forCellReuseIdentifier: SegmentedControlCell.reuseIdentifier
        )
        
        infoTableView.register(
            DatePickerCell.self,
            forCellReuseIdentifier: DatePickerCell.reuseIdentifier
        )
        
        infoTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

extension PersonalInfoViewController: PersonalInfoViewInput {
    
}

extension PersonalInfoViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        output.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = output.sections[indexPath.section]
        let model = output.cellModels[section.rawValue]
        
        switch section {
        case .name, .email:
            guard
                let model = model as? TextFieldCellModel,
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: TextFieldCell.reuseIdentifier,
                    for: indexPath
                ) as? TextFieldCell
            else { return .init() }
            
            cell.configure(with: model)
            return cell
            
        case .sex:
            guard
                let model = model as? SegmentedControlCellModel,
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: SegmentedControlCell.reuseIdentifier,
                    for: indexPath
                ) as? SegmentedControlCell
            else { return .init() }
            
            cell.configure(with: model)
            cell.segmentedControl?.addTarget(self, action: #selector(handleSexSegmentedControl), for: .valueChanged)
            return cell
            
        case .birthday:
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: DatePickerCell.reuseIdentifier,
                    for: indexPath
                ) as? DatePickerCell
            else { return .init() }
            
            cell.datePicker.addTarget(self, action: #selector(handleDateOfBirthPicker), for: .valueChanged)
            return cell
        }
    }
    
}

extension PersonalInfoViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView()
        headerView.headerTitle = output.headerTitle(at: section)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return output.heightForRowAt(at: indexPath)
    }

}
