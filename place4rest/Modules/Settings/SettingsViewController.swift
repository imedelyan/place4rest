//
//  SettingsViewController.swift
//  place4rest
//
//  Created by Igor Medelian on 2/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import PromiseKit
import UIKit

class SettingsViewController: UIViewController {

    var navigator: SettingsNavigator!
//    var userService: UserService!

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(SettingsTableViewCell.nib, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        }
    }

    private lazy var items: [Item] = {
        let logoutAction = Command(action: { [weak self] in
//            self?.showSpinner()
//            self?.userService.logout()
//                .done { [weak self] in
//                    self?.notificationCenter.post(name: .logout, object: nil)
//                }.catch { [weak self] error in
//                    self?.showError(title: nil, message: error.responseDescription)
//                }.finally { [weak self] in
//                    self?.hideSpinner()
//            }
        })
        let logoutConfirmation = Confirmation(title: R.string.localizable.settingsLogout(),
                                              message: R.string.localizable.settingsLogoutMessage(),
                                              buttonTitle: R.string.localizable.settingsLogout())

        return [
            Item(title: R.string.localizable.settingsEditUser(), action: Command(action: { [weak self] in
                self?.navigator.navigate(to: .editUser)
            })),
            Item(title: R.string.localizable.settingsLanguage(), action: Command(action: { [weak self] in
                self?.navigator.navigate(to: .language)
            })),
            Item(title: R.string.localizable.settingsWeb(), action: Command(action: { [weak self] in
                self?.navigator.navigate(to: .web)
            })),
            Item(title: R.string.localizable.settingsLogout(), confirmation: logoutConfirmation, action: logoutAction)
        ]
    }()
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier,
                                                 for: indexPath) as! SettingsTableViewCell
        cell.title = items[indexPath.row].title
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        let item = items[indexPath.row]
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

extension SettingsViewController {
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
