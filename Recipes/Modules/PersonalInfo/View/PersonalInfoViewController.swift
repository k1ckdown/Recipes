//
//  PersonalInfoViewController.swift
//  Recipes
//
//  Created by Ivan Semenov on 22.07.2023.
//

import UIKit

final class PersonalInfoViewController: BaseViewController {

    var output: PersonalInfoViewOutput!
    
    private let saveChangesButton = UIButton(type: .system)
    private let infoTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private enum Constants {
        
            enum InfoTableView {
                static let insetTop = 10
            }
            
            enum SaveChangesButton {
                static let cornerRadius: CGFloat = 10
            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = output.sceneTitle
        
        setup()
        output.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @objc
    private func handleSaveChangesButton() {
        view.endEditing(true)
        output.didTapOnSaveChangesButton()
    }
    
    @objc
    private func handleDateOfBirthPicker(sender: UIDatePicker) {
        output.didUpdateDateOfBirth(date: sender.date)
    }
    
    @objc
    private func handleSexSegmentedControl(sender: UISegmentedControl) {
        output.didSelectSexSegment(segment: sender.selectedSegmentIndex)
    }
    
    private func setup() {
        setupSaveChangesButton()
        setupInfoTableView()
    }
    
    private func setupInfoTableView() {
        view.addSubview(infoTableView)
        
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.separatorStyle = .none
        infoTableView.backgroundColor = .clear
        infoTableView.showsVerticalScrollIndicator = false
        
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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.InfoTableView.insetTop)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupSaveChangesButton() {
        view.addSubview(saveChangesButton)
        
        saveChangesButton.layer.cornerRadius = Constants.SaveChangesButton.cornerRadius
        saveChangesButton.backgroundColor = .appGray
        saveChangesButton.setTitle(output.saveChangesButtonTitle, for: .normal)
        saveChangesButton.titleLabel?.font = .saveChangesButton
        saveChangesButton.setTitleColor(.appWhite, for: .normal)
        saveChangesButton.addTarget(self, action: #selector(handleSaveChangesButton), for: .touchUpInside)
    }
    
}

// MARK: - PersonalInfoViewInput

extension PersonalInfoViewController: PersonalInfoViewInput {
    
    func refreshList() {
        infoTableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource

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
            
            cell.textField.delegate = self
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
                let model = model as? DatePickerCellModel,
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: DatePickerCell.reuseIdentifier,
                    for: indexPath
                ) as? DatePickerCell
            else { return .init() }
            
            cell.configure(with: model)
            cell.datePicker.addTarget(self, action: #selector(handleDateOfBirthPicker), for: .valueChanged)
            return cell
        }
    }
    
}

// MARK: - UITableViewDelegate

extension PersonalInfoViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView()
        headerView.headerTitle = output.headerTitle(at: section)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        output.heightForFooter(at: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return saveChangesButton
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return output.heightForRowAt(at: indexPath)
    }

}

// MARK: - UITextFieldDelegate

extension PersonalInfoViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let value = textField.text
        let type = TextFieldType(rawValue: textField.tag)
        
        switch type {
        case .email:
            output.didEndEditingEmail(value)
        case .username:
            output.didEndEditingName(value)
        default:
            return
        }
    }
    
}
