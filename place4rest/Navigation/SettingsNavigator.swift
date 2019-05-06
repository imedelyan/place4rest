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
            break
        case .editUser:
            break
        case .web:
            UIApplication.shared.open(Bundle.main.url(for: "SITE_URL"))
        }
    }

    func backToRoot() {
        navigationController.popToRootViewController(animated: true)
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
