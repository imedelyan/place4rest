//
//  SettingsPresenter.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import PromiseKit

final class SettingsPresenter {

    typealias Props = SettingsViewController.Props
    typealias Item = SettingsViewController.Item

    // MARK: - Dependencies
    private let storageService: KeychainStorageService
    private let userService: UserService
    weak var view: SettingsView!

    // MARK: - Init
    init(userService: UserService, storageService: KeychainStorageService) {
        self.userService = userService
        self.storageService = storageService
    }

    // MARK: - SearchView
    func viewWillAppear() {
        view.render(props: makeProps())
    }

    // MARK: - Login
    private func logout() {
        Loader.show()
        userService.logout()
            .done { [weak self] in
                guard let self = self else { return }
                self.storageService.clearToken()
                self.view.render(props: self.makeProps())
            }.catch { [weak self] error in
                guard let self = self else { return }
                self.storageService.clearToken() // TODO: remove these lines when API will be ready
                self.view.render(props: self.makeProps())

                //                    self?.showError(title: nil, message: error.localizedDescription)
            }.finally {
                Loader.hide()
        }
    }
}

// MARK: - Props Factory
extension SettingsPresenter {
    private func makeProps() -> Props {

        let logoutAction = Command(action: { [weak self] in
            self?.logout()
        })
        let logoutConfirmation = SettingsViewController.Confirmation(title: R.string.localizable.settingsLogout(),
                                                                     message: R.string.localizable.settingsLogoutMessage(),
                                                                     buttonTitle: R.string.localizable.settingsLogout())

        var items = [
            Item(title: R.string.localizable.settingsLanguage(),
                 action: Command(action: { [weak self] in
                    self?.view.showLanguage()
                 })),
            Item(title: R.string.localizable.settingsWeb(),
                 action: Command(action: { [weak self] in
                    self?.view.showWeb()
                 }))
        ]
        if !storageService.token.isEmpty {
            items += [
                Item(title: R.string.localizable.settingsEditUser(),
                     action: Command(action: { [weak self] in
                        self?.view.showEditUser()
                     })),
                Item(title: R.string.localizable.settingsLogout(),
                     confirmation: logoutConfirmation,
                     action: logoutAction)
            ]
        }

        return Props(items: items)
    }
}
