//
//  SettingsViewController.swift
//  place4rest
//
//  Created by Igor Medelian on 2/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(SettingsTableViewCell.nib, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        }
    }

    // MARK: - Dependencies
    var presenter: SettingsPresenter!
    var navigator: SettingsNavigator!

    // MARK: - Variables
    private var props = Props(items: [])

    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }

}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier,
                                                 for: indexPath) as! SettingsTableViewCell
        cell.title = props.items[indexPath.row].title
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        let item = props.items[indexPath.row]
        guard let confirmation = item.confirmation else {
            item.action.perform()
            return
        }
        UIAlertController
            .makeConfirmation(title: confirmation.title,
                              message: "\n" + confirmation.message,
                              confirmTitle: confirmation.buttonTitle,
                              confirmed: item.action)
            .present(from: self)
    }
}

// MARK: - PlaceView
protocol SettingsView: class {
    func render(props: SettingsViewController.Props)
    func showLanguage()
    func showWeb()
    func showEditUser()
}

extension SettingsViewController: SettingsView {
    func render(props: Props) {
        self.props = props
        tableView.reloadData()
    }

    func showLanguage() {
        navigator.navigate(to: .language)
    }

    func showWeb() {
        navigator.navigate(to: .web)
    }

    func showEditUser() {
        navigator.navigate(to: .editUser)
    }
}

// MARK: - Props
extension SettingsViewController {
    struct Props {
        let items: [Item]
    }

    struct Confirmation {
        let title: String
        let message: String
        let buttonTitle: String
    }

    struct Item {
        let title: String
        let confirmation: Confirmation?
        let action: Command

        init(title: String,
             confirmation: Confirmation? = nil,
             action: Command) {
            self.title = title
            self.confirmation = confirmation
            self.action = action
        }
    }
}
