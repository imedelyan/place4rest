//
//  SettingsNavigator.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/6/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

final class SettingsNavigator {

    let navigationController: UINavigationController

    // MARK: - Init
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
        navigate(to: .settings)
    }

    // MARK: - Navigations
    func navigate(to destination: Step) {
        switch destination {
        case .settings:
            let vc = SettingsViewController.load(from: .settings)
            vc.navigator = self
            navigationController.pushViewController(vc, animated: true)
        case .language:
            let vc = LanguagesViewController.load(from: .languages)
            vc.onSetAction = { [weak self] language in
                AppLanguage.language = language
                self?.showAlertForLanguageChange()
            }
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            navigationController.topViewController?.present(vc, animated: true, completion: nil)
        case .editUser:
            break
        case .web:
            UIApplication.shared.open(Bundle.main.url(for: "SITE_URL"))
        }
    }

    func backToRoot() {
        navigationController.popToRootViewController(animated: true)
    }

    private func showAlertForLanguageChange() {
        guard AppLanguage.language != AppLanguage.startLanguage else { return }
        let restartAppAlert = UIAlertController(title: R.string.localizable.restartApplication(),
                                                message: nil,
                                                preferredStyle: .alert)
        restartAppAlert.addAction(UIAlertAction(title: R.string.localizable.ok(), style: .cancel, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(restartAppAlert, animated: true, completion: nil)
    }
}

extension SettingsNavigator {
    enum Step {
        case settings
        case language
        case editUser
        case web
    }
}
