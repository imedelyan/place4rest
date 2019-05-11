//
//  LoginNavigator.swift
//  place4rest
//
//  Created by Igor Medelyan on 5/11/19.
//  Copyright © 2019 imedelian. All rights reserved.
//

import UIKit

final class LoginNavigator {

    let navigationController: UINavigationController
    var onDissmiss: Command?

    // MARK: - Init
    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
        navigate(to: .login)
    }

    // MARK: - Navigations
    func navigate(to destination: Step) {
        switch destination {
        case .login:
            let vc = LoginViewController.load(from: .login)
            vc.navigator = self
            navigationController.pushViewController(vc, animated: true)
        case .register:
            break
        case .forgotPassword:
            break
        }
    }

    func dismiss() {
        onDissmiss?.perform()
    }
}

extension LoginNavigator {
    enum Step {
        case login
        case register
        case forgotPassword
    }
}
